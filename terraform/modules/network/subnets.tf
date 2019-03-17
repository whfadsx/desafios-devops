resource "aws_subnet" "sn" {
  count                   = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  availability_zone       = "${var.az_availables_name[count.index]}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr,8,count.index)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = false

  tags = "${
    map(
     "Name", "sn-${var.environment}-${count.index}"
    )
  }"
}

resource "aws_subnet" "sn-private" {
  count                   = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  availability_zone       = "${var.az_availables_name[count.index]}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr,8,count.index + 10)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = false

  tags = "${
    map(
     "Name", "sn-private-${var.environment}-${count.index}"
    )
  }"
}

resource "aws_subnet" "sn-private-db" {
  count                   = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  availability_zone       = "${var.az_availables_name[count.index]}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr,8,count.index + 20)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = false

  tags = "${
    map(
     "Name", "sn-private-db-${var.environment}-${count.index}"
    )
  }"
}
