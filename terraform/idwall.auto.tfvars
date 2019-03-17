project_name = "idwall"

environment = "default"

user_data_lc = "docker run -d -p 80:80 --name idwall-app httpd:2.4"

ec2_instance_size = "t2.micro"

vpc_cidr = "10.50.0.0/16"

create_enabled = "true"
