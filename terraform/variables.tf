variable "ecs_ami_id" {
  default = ""
}

variable "project_name" {}

variable "environment" {}

variable "user_data_lc" {
  default = ""
}

variable "ec2_instance_size" {}

variable "vpc_cidr" {}

variable "src_ip" {}

variable "region" {}

variable "create_enabled" {
  default = "true"
}
