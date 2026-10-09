module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${local.name}-vpc"

  cidr = local.vpc_cidr

  azs = local.azs

  private_subnets = local.private_subnets

  public_subnets = local.public_subnets

  enable_nat_gateway = true

  single_nat_gateway = true

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}