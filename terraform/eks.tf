module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.10.0"

  cluster_name    = "particle41-challenge"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default_node_group = {
      min_size     = var.nodes_min_size
      max_size     = var.nodes_max_size
      desired_size = var.nodes_desired_size
      instance_types = var.nodes_instance_types
    }
  }

  tags = {
    Project = "particle41-challenge"
  }
}
