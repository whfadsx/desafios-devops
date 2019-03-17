resource "aws_autoscaling_group" "asg" {
  desired_capacity     = "${var.environment == "prod" ? 3 : 1}"
  launch_configuration = "${aws_launch_configuration.lc.id}"
  max_size             = "${var.environment == "prod" ? 10 : 5}"
  min_size             = "${var.environment == "prod" ? 3 : 1}"
  name                 = "${var.project_name}-asg"
  vpc_zone_identifier  = ["${var.subnet_ids}"]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg"
    propagate_at_launch = true
  }
}

locals {
  ec2_idwall_userdata = <<USERDATA
#!/bin/bash
${var.user_data_lc}
USERDATA
}

resource "aws_launch_configuration" "lc" {
  name                        = "${var.project_name}-lc"
  associate_public_ip_address = true
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.ec2_instance_size}"
  security_groups             = ["${var.ec2_sg_id}"]
  user_data_base64            = "${base64encode(local.ec2_idwall_userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}
