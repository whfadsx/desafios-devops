resource "aws_security_group" "sg" {
  name        = "${var.project_name}-sg"
  description = "Security group"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = "${
    map(
     "Name", "${var.project_name}-sg"
     )
  }"
}
