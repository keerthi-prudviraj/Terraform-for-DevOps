resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# Latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Default VPC

resource "aws_default_vpc" "default" {
}

# Security Group

resource "aws_security_group" "my_security_group" {
  name        = "automated-sg"
  description = "Security group for my EC2 instance"
  vpc_id      = aws_default_vpc.default.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automated-sg"
  }
}

# EC2 Instance

resource "aws_instance" "my_ec2_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance_type

  key_name = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data              = file("${path.module}/Install.sh")
  root_block_device {
    volume_size = var.aws_root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "PR_EC2_Instance"
  }
}