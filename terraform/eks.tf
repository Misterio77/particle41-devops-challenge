module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.10.0"

  cluster_name    = "particle41-challenge"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default_node_group = {
      min_size     = 1
      max_size     = 10
      desired_size = 2
      instance_types = ["t2.small"]
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    Project = "particle41-challenge"
  }
}
