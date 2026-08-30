module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs = ["${var.aws_region}a", "${var.aws_region}b"]

  # Public subnets: only for the ALB (added later) and the NAT Gateway.
  # No application workloads run here.
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  # Private subnets: EKS worker nodes and our app pods live here,
  # with no direct public IPs — matches real production practice.
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  # Single NAT Gateway (not one-per-AZ) — real production often uses
  # one per AZ for high availability, but that doubles the cost.
  # One shared NAT Gateway is a deliberate, documented lab trade-off:
  # correct architecture pattern, reduced redundancy to control cost.
  enable_nat_gateway = true
  single_nat_gateway = true

  map_public_ip_on_launch = false

  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true
}
