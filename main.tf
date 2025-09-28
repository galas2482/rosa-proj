terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.20.0"
    }
    rhcs = {
      version = ">= 1.6.3"
      source = "terraform-redhat/rhcs"
    }
  }
}

provider "rhcs" {}

provider "aws" {
  region = var.aws_region
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
  default_tags {
    tags = {
      Project     = "rosa-lab"
      Owner       = "gabe"
      ManagedBy   = "Terraform"
      Environment = "test"
    }
  }
}

data "aws_availability_zones" "available" {}

locals {

  region_azs = var.multi_az ? slice([for zone in data.aws_availability_zones.available.names : format("%s", zone)], 0, 3) : slice([for zone in data.aws_availability_zones.available.names : format("%s", zone)], 0, 1)

}

resource "random_string" "rosa_name" {
  length  = 6
  special = false
  upper   = false
}

locals {
  worker_node_replicas = var.multi_az ? 3 : 2
}

resource "time_sleep" "wait_60_seconds" {
  count = var.create_vpc ? 1 : 0
  depends_on = [module.vpc]
  create_duration = "60s"
}

module "rosa-hcp" {
  source                 = "terraform-redhat/rosa-hcp/rhcs"
  version                = "1.6.3"
  cluster_name           = local.cluster_name
  openshift_version      = var.openshift_version
  account_role_prefix    = local.cluster_name
  operator_role_prefix   = local.cluster_name
  replicas               = local.worker_node_replicas
  aws_availability_zones = local.region_azs
  create_oidc            = true
  private                = var.private_cluster
  aws_subnet_ids         = local.cluster_subnets 
  create_account_roles   = true
  create_operator_roles  = true

  depends_on = [time_sleep.wait_60_seconds]
}
