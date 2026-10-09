module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.name
  kubernetes_version = "1.33"

  endpoint_public_access  = true
  endpoint_private_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      name = "eks-nodes"

      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      key_name = aws_key_pair.my_key.key_name
    }
  }

  tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}