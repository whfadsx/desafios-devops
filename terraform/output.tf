output "ec2_public_ip" {
  value = "${module.ec2.ec2_public_ip}"
}

output "site" {
  value = "Acesse a página http em: http://${element(module.ec2.ec2_public_ip, 0)}"
}
