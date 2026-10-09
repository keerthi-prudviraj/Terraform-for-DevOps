variable "aws_instance_type" {
  default = "t3.micro"
  type    = string
}

variable "aws_region" {
  default = "eu-west-1"
  type    = string
}
variable "aws_root_volume_size" {
  default = 15
  type    = number
}