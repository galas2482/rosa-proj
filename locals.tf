locals {
  cluster_name        = "gabes-cool-rosa-cluster"
  worker_node_replias = 3
  regions_azs         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_public_subnets  = var.create_vpc ? module.vpc[0].public_subnets  : []
  vpc_private_subnets = var.create_vpc ? module.vpc[0].private_subnets : []
  cluster_subnets     = var.create_vpc ? (var.private_cluster ? module.vpc.private_subnets : concat(module.vpc[0].public_subnets, module.vpc[0].private_subnets)) : var.aws_subnet_ids
}

