data "aws_instances" "ec2" {
  instance_tags {
    Name = "${var.project_name}-asg"
  }
}

output "ec2_public_ip" {
  value = "${data.aws_instances.ec2.public_ips}"
}
