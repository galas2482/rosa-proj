module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  count = var.create_vpc ? 1 : 0
  name  = var.vpc_name
  cidr  = var.vpc_cidr_block
  
  azs             = local.region_azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.additional_tags
}
