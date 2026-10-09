resource "aws_s3_bucket" "remote_s3" {
    bucket = "${var.env}-infra-app-bucket-${var.bucket_name}"
  tags = {
    Name = "${var.env}-infra-app-s3"
    environment = "${var.env}" 
  }
}