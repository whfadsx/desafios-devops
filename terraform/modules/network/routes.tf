resource "aws_internet_gateway" "igw" {
  count  = "${var.enabled == "true" ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = "${var.enabled == "true" ? 1 : 0}"
  allocation_id = "${aws_eip.eip-nat.id}"
  subnet_id     = "${aws_subnet.sn.0.id}"

  tags {
    Name = "${var.project_name}-${var.environment}-ngw"
  }
}

resource "aws_eip" "eip-nat" {
  count = "${var.enabled == "true" ? 1 : 0}"
  vpc   = true

  tags {
    Name = "${var.project_name}-${var.environment}-ngw-eip"
  }
}

resource "aws_route_table" "rt" {
  count  = "${var.enabled == "true" ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.project_name}-${var.environment}-rt"
  }
}

resource "aws_route_table" "rt-private" {
  count  = "${var.enabled == "true" ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags {
    Name = "${var.project_name}-${var.environment}-rt-private"
  }
}

resource "aws_route_table" "rt-private-db" {
  count  = "${var.enabled == "true" ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.project_name}-${var.environment}-rt-private-db"
  }
}

resource "aws_route_table_association" "rta" {
  count          = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  subnet_id      = "${element(aws_subnet.sn.*.id, count.index)}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_route_table_association" "rta-private" {
  count          = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  subnet_id      = "${element(aws_subnet.sn-private.*.id, count.index)}"
  route_table_id = "${aws_route_table.rt-private.id}"
}

resource "aws_route_table_association" "rta-private-db" {
  count          = "${var.enabled == "true" ? 1 * length(var.az_availables_name) : 0}"
  subnet_id      = "${element(aws_subnet.sn-private-db.*.id, count.index)}"
  route_table_id = "${aws_route_table.rt-private-db.id}"
}
