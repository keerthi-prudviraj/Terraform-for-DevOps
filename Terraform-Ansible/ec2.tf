resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2-ansible"
  public_key = file("terra-key-ansible.pub")
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
  for_each = tomap({
    Tws-junoon-Master = "ami-06468be052a4195a6", #ubuntu
    Tws-junoon-01     = "ami-06468be052a4195a6", #ubuntu
    Tws-junoon-02     = "ami-02549ba88824a9726", #redhat
    Tws-junoon-03     = "ami-0bf05131040dbf2fc"  #amazon linux
  })
  depends_on    = [aws_security_group.my_security_group, aws_key_pair.my_key]
  ami           = each.value
  instance_type = "t3.micro"

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  user_data       = file("${path.module}/Install.sh")
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}