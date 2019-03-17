data "aws_ami" "ecs_ami" {
  filter {
    name = "name"

    values = [
      "*amazon-ecs-optimized",
    ]
  }

  most_recent = true

  owners = [
    "amazon",
  ]
}

data "aws_availability_zones" "available" {}

provider "aws" {
  region = "${var.region}"
}

module "network" {
  source = "modules/network"

  enabled            = "${var.create_enabled}"
  vpc_cidr           = "${var.vpc_cidr}"
  project_name       = "${var.project_name}"
  az_availables_name = "${data.aws_availability_zones.available.names}"
  environment        = "${var.environment}"
}

module "sg" {
  source = "modules/sg"

  vpc_id       = "${module.network.vpc_id}"
  project_name = "${var.project_name}"
}

module "sg_rule_http" {
  source = "modules/sg_rule"

  src_ip    = ["0.0.0.0/0"]
  src_port  = "80"
  dest_port = "80"
  sg_id     = "${module.sg.sg_id}"
}

module "sg_rule_https" {
  source = "modules/sg_rule"

  src_ip    = ["0.0.0.0/0"]
  src_port  = "443"
  dest_port = "443"
  sg_id     = "${module.sg.sg_id}"
}

module "sg_rule_ssh" {
  source = "modules/sg_rule"

  src_ip    = ["${var.src_ip}"]
  src_port  = "22"
  dest_port = "22"
  sg_id     = "${module.sg.sg_id}"
}

module "ec2" {
  source = "modules/ec2"

  user_data_lc      = "${var.user_data_lc}"
  project_name      = "${var.project_name}"
  ami_id            = "${var.ecs_ami_id == "" ? data.aws_ami.ecs_ami.id : var.ecs_ami_id}"
  ec2_sg_id         = "${module.sg.sg_id}"
  environment       = "${var.environment}"
  ec2_instance_size = "${var.ec2_instance_size}"
  subnet_ids        = "${module.network.sn_ids}"
}
