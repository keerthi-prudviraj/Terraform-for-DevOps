resource "aws_key_pair" "my_key" {
  key_name   = "terraform-eks-key"
  public_key = file("terra-key-ec2.pub")

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}