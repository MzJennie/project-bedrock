output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "assets_bucket_name" {
  description = "S3 assets bucket name"
  value       = module.s3_lambda.assets_bucket_name
}

output "mysql_endpoint" {
  description = "MySQL RDS endpoint"
  value       = module.rds.mysql_endpoint
}

output "postgres_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = module.rds.postgres_endpoint
}

output "dev_view_access_key_id" {
  description = "Developer IAM user access key"
  value       = module.iam.dev_view_access_key_id
  sensitive   = true
}

output "dev_view_secret_access_key" {
  description = "Developer IAM user secret key"
  value       = module.iam.dev_view_secret_access_key
  sensitive   = true
}

output "dev_view_password" {
  description = "Developer IAM user console password"
  value       = module.iam.dev_view_password
  sensitive   = true
}
