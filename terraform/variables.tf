variable "aws_region_name" {
  type    = string
  description = "Region"
  default = "eu-central-1"
}

variable "cluster_name" {
  type    = string
  description = "Cluster name"
  default = "demo"
}

variable "availability_zones" {
  type    = list(string)
  description = "Availability Zones"
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  description = "Public subnet CIDRs"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  description = "Private subnet CIDRs"
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "ecr_repositories" {
  description = "Map ECR repositories"
  type        = map(any)
  default = {
    content-api = {
      expiration_after_days = 14
      scanning_enabled      = false
      tag_mutability        = "MUTABLE"
    },
    rails-app = {
      expiration_after_days = 14
      scanning_enabled      = false
      tag_mutability        = "MUTABLE"
    },
    worker = {
      expiration_after_days = 14
      scanning_enabled      = false
      tag_mutability        = "MUTABLE"
    }
  }
}