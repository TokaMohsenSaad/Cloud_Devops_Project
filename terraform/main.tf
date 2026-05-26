terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "cloud-project1233"
    key    = "cloud-devops-project/terraform.tfstate" //path of the state file in the bucket
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"
  az_count = 2
  vpc_cidr = "10.0.0.0/16"
  cluster_name = module.eks.cluster_name 
  enable_nat_gateway = true
  single_nat_gateway = false  //since we need high availability in different AZs
}

module "server" {
  source           = "./modules/server"
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_ids[0]
  key_name         = "access-key-project"
  ami_id           = "ami-0c7217cdde317cfec"
}

module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "clouddevops-eks"
  private_subnet_ids = module.network.private_subnet_ids
}

module "iam_lb_controller" {
  source = "./modules/iam-lb-controller"

  cluster_name    = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_issuer_url = module.eks.cluster_oidc_issuer_url
}

# Print the role ARN after terraform apply
output "lb_controller_role_arn" {
  value = module.iam_lb_controller.lb_controller_role_arn
}