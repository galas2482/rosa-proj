variable "openshift_version" {
  description = "The version that for ROSA Openshift that will be implemented"
  type        = string
}

variable "private_cluster" {
  description = "API/ingress boolean for controlling privacy"
  type        = bool
  default     = false
}

variable "create_vpc" {
  description = "Checks if there is an exisitng VPC and offers to use that one or create a new one"
  type        = bool
  default     = true
}

variable "additional_tags" {
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
  description = "Additional AWS resource tags"
  type        = map(string)
}

variable "multi_az" {
  type        = bool
  description = "Multi AZ Cluster for High Availability"
  default     = true
}

variable "worker_node_replicas" {
  default     = 3
  description = "Number of worker nodes to provision. Single zone clusters need at least 2 nodes, multizone clusters need at least 3 nodes"
  type        = number
}

variable "aws_subnet_ids" {
  type        = list(any)
  description = "A list of either the public or public + private subnet IDs to use for the cluster blocks to use for the cluster"
  default     = ["subnet-01234567890abcdef", "subnet-01234567890abcdef", "subnet-01234567890abcdef"]
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "gabe-tf-rosa"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type        = list(any)
  description = "CIDR blocks for the private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  type        = list(any)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single NAT or per NAT for subnet"
  default     = false
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "default_aws_tags" {
  type        = map(string)
  description = "Default tags for AWS"
  default     = { 
      Project     = "rosa-lab"
      Owner       = "gabe"
      ManagedBy   = "Terraform"
      Environment = "test"
  }
}

variable "rhcs_token" {
  type      = string
  sensitive = true
}


