# Desafio 02: Kubernetes

## Status

Feito<br>
Extras feito

## Instruções de uso

O shell script <i>idwall.sh</i> irá procurar pelas dependências necessárias e fará a instalação das mesmas. As únicas dependências que não são instaladas pelo scripts e necessárias para execução são:<br>
- git
- VirtualBox

O script não realiza nenhum desinstalação e nem o delete do minikube. Após os testes é recomendado executar o comando:<br>
```bash
$ minikube delete
```
Qualquer desinstalação das dependências é necessário executá-la manualmente.

O script foi desenvolvido para distros debian-like e redhat-like, porém, foi testado apenas no Fedora 29 e Ubuntu 18.04.

## Dependências
- git
- VirtualBox
- Minikube
- Helm
- Kubectl

## Execução
- Clone esse repositório e entre no diretório kubernetes
```
$ git clone https://github.com/whfadsx/desafios-devops.git
$ cd desafios-devops/kubernetes
```
- Execute o script
```
$ ./idwall.sh
```
O script pedirá o input de uma url para aplicação e o nome do executor para saudação na aplicação.
Se o input for vazio, o default para url é <i>idwall.local</i> e <i>candidato</i> para o nome.
Não foi desenvolvido qualquer validação para esses inputs.

## Notas

- Foi utilizado Helm para prover o app.