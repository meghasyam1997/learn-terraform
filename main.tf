resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.ami.id
  instance_type          = each.value["instance"]
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

resource "aws_route53_record" "records" {
  for_each = var.components
  name     = "${each.value["name"]}-${var.env}.msdevops72.online"
  type     = "A"
  ttl      = 30
  zone_id  = "Z024184021A09H13X7MEW"
  records  = [aws_instance.instance[each.value["name"]].private_ip]
}
