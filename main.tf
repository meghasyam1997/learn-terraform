resource "aws_instance" "instance" {
  count                  = 10
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = "my_instances_${count.index}"
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