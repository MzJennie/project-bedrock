terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

module "vpc" {
  source             = "./modules/vpc"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  tags               = var.tags
}

module "security_groups" {
  source       = "./modules/security-groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = module.vpc.vpc_cidr
  tags         = var.tags
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
}

module "eks" {
  source               = "./modules/eks"
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  public_subnet_ids    = module.vpc.public_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_nodes_role_arn   = module.iam.eks_nodes_role_arn
  eks_nodes_sg_id      = module.security_groups.eks_nodes_sg_id
  node_instance_type   = "t3.small"
  node_desired_size    = 5
  node_min_size        = 1
  node_max_size        = 5
  tags                 = var.tags
}

module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  rds_mysql_sg_id      = module.security_groups.rds_mysql_sg_id
  rds_postgres_sg_id   = module.security_groups.rds_postgres_sg_id
  db_password_mysql    = var.db_password_mysql
  db_password_postgres = var.db_password_postgres
  tags                 = var.tags
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
  tags         = var.tags
}

module "s3_lambda" {
  source          = "./modules/s3-lambda"
  project_name    = var.project_name
  student_id      = var.student_id
  lambda_role_arn = module.iam.lambda_role_arn
  tags            = var.tags
}
