# Project Bedrock - InnovateMart EKS Deployment

## Architecture Overview

* VPC with public/private subnets across 2 AZs
* EKS cluster (project-bedrock-cluster) with managed node groups
* RDS MySQL and PostgreSQL in private subnets
* DynamoDB for cart/order data
* S3 + Lambda for asset processing
* CloudWatch for observability
* ALB Ingress Controller for external access

## Prerequisites

* AWS CLI configured
* Terraform >= 1.0
* kubectl
* helm

### Repository Clone Notes
This repository contains the `retail-store-sample-app` as a Git submodule.
After cloning the repository, initialize the submodule using:

```bash
git submodule update --init --recursive
```

Alternatively, clone the repository and all submodules in a single command:

```bash
git clone --recurse-submodules https://github.com/MzJennie/project-bedrock.git
```

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

### 3. Application Deployment

#### Create Namespace

```bash
kubectl apply -f kubernetes/retail-app/namespace.yaml
```

#### Add Helm Repository

```bash
helm repo add aws-retail https://aws-containers.github.io/retail-store-sample-app
helm repo update
```

#### Deploy Retail Store Application

```bash
helm upgrade --install retail-store aws-retail/retail-store-sample-app \
  --namespace retail-app \
  --create-namespace \
  --values kubernetes/retail-app/values.yaml
```

#### Verify Deployment

```bash
kubectl get pods -n retail-app
kubectl get ingress -n retail-app
```

### 4. Get Application URL

```bash
kubectl get ingress -n retail-app
```

Example:

```text
project-bedrock.54.165.244.253.nip.io
```

#### Architecture Diagram

See `Architecture-Diagram.png` included in the submission package.

## Managed Data Layer

The application uses managed AWS services instead of in-cluster databases:

| Component | AWS Service           |
| --------- | --------------------- |
| Catalog   | Amazon RDS MySQL      |
| Orders    | Amazon RDS PostgreSQL |
| Cart      | Amazon DynamoDB       |

## Observability

### EKS Control Plane Logging

The following EKS control plane logs are enabled and forwarded to Amazon CloudWatch:

* API
* Audit
* Authenticator
* Controller Manager
* Scheduler

### Container Logging

Container logs are shipped to Amazon CloudWatch using the CloudWatch Observability solution.

## Event-Driven Extension

### S3 Bucket

```text
bedrock-assets-alt-soe-025-3635
```

### Lambda Function

```text
bedrock-asset-processor
```

### Workflow

```text
S3 Upload
    ↓
S3 Event Notification
    ↓
Lambda Invocation
    ↓
CloudWatch Logs
```

Example Lambda output:

```text
Image received: filename.ext
```

## Networking

### Public Endpoint

```text
project-bedrock.54.165.244.253.nip.io
```

### Ingress

* AWS Load Balancer Controller
* Application Load Balancer (ALB)
* nip.io DNS

## CI/CD Pipeline

* Pull Request (PR-TEST) → Terraform Plan posted as PR comment
* Merge to main → Terraform Apply

### Workflow Features

* Terraform Init
* Terraform Validate
* Terraform Plan
* Pull Request Comments
* Terraform Apply on Merge
* GitHub Actions Secrets for AWS Credentials

## Developer Access

* Console URL: https://082884564197.signin.aws.amazon.com/console
* Username: bedrock-dev-view
* Credentials provided in submission document

### Permissions

AWS:

* ReadOnlyAccess
* S3 PutObject access to assets bucket

Kubernetes:

* ClusterRole: view

## Resources

* EKS Cluster: project-bedrock-cluster
* Region: us-east-1
* Namespace: retail-app
* Assets Bucket: bedrock-assets-alt-soe-025-3635
* Lambda Function: bedrock-asset-processor

## Repository Structure

```text
project-bedrock/
├── terraform/
├── kubernetes/
├── lambda/
├── monitoring/
├── helm/
├── retail-store-sample-app/
└── README.md
```
