module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  bucket_name    = "pr-dev-infra-app-bucket-2026"
  instance_count = 1
  instance_type  = "t3.micro"
  ami_id         = "ami-00bf3d24573e7276a"
  hash_key       = "student_id"
}

module "staging-infra" {
  source         = "./infra-app"
  env            = "staging"
  bucket_name    = "pr-staging-infra-app-bucket-2026"
  instance_count = 1
  instance_type  = "t3.micro"
  ami_id         = "ami-00bf3d24573e7276a"
  hash_key       = "student_id"
}

module "prd-infra" {
  source         = "./infra-app"
  env            = "prd"
  bucket_name    = "pr-prd-infra-app-bucket-2026"
  instance_count = 2
  instance_type  = "t3.small"
  ami_id         = "ami-00bf3d24573e7276a"
  hash_key       = "student_id"
}