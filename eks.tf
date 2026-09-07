module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name               = var.cluster_name
  kubernetes_version = var.cluster_version
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  endpoint_public_access  = true
  endpoint_private_access = true
  # Grants the identity running `terraform apply` cluster-admin access
  # automatically via EKS Access Entries (current standard — replaces
  # the legacy aws-auth ConfigMap approach).
  enable_cluster_creator_admin_permissions = true
  enable_irsa = true
  addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { 
      most_recent = true 
      before_compute = true 
    }
  }
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      subnet_ids = module.vpc.private_subnets
    }
  }
  tags = {
    Environment = var.environment
  }
}
