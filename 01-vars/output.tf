variable "instance" {
  default = ""
}
output "instance_type" {
  value = var.instance
}
variable "env" {
  default = ""
}
output "instance" {
  value = var.env
}