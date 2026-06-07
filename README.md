# Project Bedrock - InnovateMart EKS Deployment

## Architecture Overview
- VPC with public/private subnets across 2 AZs
- EKS cluster (project-bedrock-cluster) with managed node groups
- RDS MySQL and PostgreSQL in private subnets
- DynamoDB for cart/order data
- S3 + Lambda for asset processing
- CloudWatch for observability
- ALB Ingress Controller for external access

## Prerequisites
- AWS CLI configured
- Terraform >= 1.0
- kubectl
- helm

## Quick Start

### 1. Deploy Infrastructure
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your passwords
terraform init
terraform apply
```

### 2. Configure kubectl
```bash
aws eks update-kubeconfig --region us-east-1 --name project-bedrock-cluster
```

### 3. Deploy Application
```bash
kubectl apply -f kubernetes/retail-app/namespace.yaml
helm repo add aws-retail https://aws-containers.github.io/retail-store-sample-app
helm upgrade --install retail-store aws-retail/retail-store-sample-app \
  --namespace retail-app \
  --values kubernetes/retail-app/values.yaml
```

### 4. Get Application URL
```bash
kubectl get ingress -n retail-app
```

## CI/CD Pipeline
- Pull Request (PR-TEST) → Terraform Plan posted as PR comment
- Merge to main → Terraform Apply

## Developer Access
- Console URL: https://082884564197.signin.aws.amazon.com/console
- Username: bedrock-dev-view
- Credentials in submission document

## Resources
- EKS Cluster: project-bedrock-cluster
- Region: us-east-1
- Namespace: retail-app
- Assets Bucket: bedrock-assets-alt-soe-025-3635
