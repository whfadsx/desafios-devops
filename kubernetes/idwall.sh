#!/bin/bash
which dpkg &> /dev/null
has_dpkg="$?"

which rpm &> /dev/null
has_rpm="$?"

echo "Verifying dependencies..."
which kubectl &> /dev/null
has_kubectl="$?"
which minikube &> /dev/null
has_minikube="$?"
which helm &> /dev/null
has_helm="$?"


echo -e "Digite a url desejada para acessar a aplicação: (ex. idwall.local)"
read host_url

echo -e "Qual é a sua graça, por obséquio?"
read username

if [[ "${has_dpkg}" == "0" ]]
then
    # Block to install kubectl
    if [[ "$has_kubectl" != "0" ]]
    then
        echo "Installing kubectl..."
        sudo apt-get update -y && sudo apt-get install -y apt-transport-https
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
        sudo apt-get update -y
        sudo apt-get install -y kubectl
    fi

    # Installing minikube
    if [[ "$has_minikube" != "0" ]]
    then
        echo "Installing minikube..."
        curl -sLo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
        sudo mv minikube /usr/local/bin
    fi

    # Installing helm
    if [[ "$has_helm" != "0" ]]
    then
        echo "Installing helm..."
        curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get | sudo bash
    fi

elif [[ "${has_rpm}" == "0" ]]
then
    # Block to install kubectl
    if [[ "$has_kubectl" != "0" ]]
    then
        echo "Installing kubectl..."
        cat <<EOF |sudo tee -a /etc/yum.repos.d/kubernetes.repo &> /dev/null
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
        sudo yum install -y kubectl
    fi

    # Installing minikube
    if [[ "$has_minikube" != "0" ]]
    then
        echo "Installing minikube..."
        curl -sLo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
        sudo mv minikube /usr/local/bin
    fi

    # Installing helm
    if [[ "$has_helm" != "0" ]]
    then
        echo "Installing helm..."
        curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get | sudo bash
    fi

fi

minikube start

ready_minikube=$!

wait $ready_minikube

minikube addons enable ingress

eval $(minikube docker-env)

docker build -t idwall-app:local .

helm init

if [[ "${host_url}" == "" ]]
then
    host_url="idwall.local"
    sudo sed -i "/${host_url}/d" /etc/hosts
    echo "$(minikube ip) ${host_url}" | sudo tee -a  /etc/hosts &> /dev/null
else
    sudo sed -i "/${host_url}/d" /etc/hosts
    echo "$(minikube ip) ${host_url}" | sudo tee -a  /etc/hosts &> /dev/null
fi

sleep 60

if [[ "${username}" == "" ]]
then
    username="candidato"
fi

helm install ./idwall-app --set name="$username"  --set "ingress.hosts[0].host=${host_url}" --set "ingress.hosts[0].paths[0]=/" --namespace idwall
