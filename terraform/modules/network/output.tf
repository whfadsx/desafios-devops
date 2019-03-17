output "sn_ids" {
  value = ["${aws_subnet.sn.*.id}"]
}

output "sn_private_ids" {
  value = "${aws_subnet.sn-private.*.id}"
}

output "sn_private_db_ids" {
  value = "${aws_subnet.sn-private-db.*.id}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}