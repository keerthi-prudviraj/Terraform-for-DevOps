resource "aws_s3_bucket" "remote_s3" {
    bucket = "pr-remote-infra-s3"
  tags = {
    Name = "pr-remote-infra-s3"
    environment = "dev"
  }
}