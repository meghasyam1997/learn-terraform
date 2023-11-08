resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.ami.id
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = "${each.value["name"]}-${var.env}"
  }
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

data "aws_security_group" "allow_all" {
  name = "allow-all"
}
