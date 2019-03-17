resource "aws_vpc" "vpc" {
  count                = "${var.enabled == "true" ? 1 : 0}"
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = "${
    map(
     "Name", "${var.project_name}-${var.environment}-vpc"
    )
  }"
}
