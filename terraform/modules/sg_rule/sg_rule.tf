resource "aws_security_group_rule" "sg_rule" {
  description       = "Security group rule for sg"
  from_port         = "${var.src_port}"
  protocol          = "tcp"
  security_group_id = "${var.sg_id}"
  cidr_blocks       = ["${var.src_ip}"]
  to_port           = "${var.dest_port}"
  type              = "ingress"
}
