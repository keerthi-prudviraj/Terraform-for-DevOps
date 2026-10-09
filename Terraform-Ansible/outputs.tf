output "ec2_public_ip" {
  value = {
    for key, instance in aws_instance.my_ec2_instance : key => instance.public_ip
  }
}