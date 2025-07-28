# ecs-deployment

This repository contains Terraform infrastructure as code (IaC) modules designed to deploy containerized applications on **AWS Elastic Container Service (ECS)**, with all networking handled via an AWS **Virtual Private Cloud (VPC)**.

## Overview

This project provisions and manages AWS infrastructure consisting of:

- A **VPC** with appropriate subnets, route tables, and internet gateway for robust, secure networking
- **Security groups** for traffic control
- An **ECS cluster** using the **Fargate launch type** for serverless container management
- **ECS services and task definitions** to orchestrate your containerized applications
- **IAM roles and policies** granting necessary permissions for ECS and related networking

All components are modular Terraform code, promoting flexibility and maintainability.

## Repository Structure


├── main.tf                # Root Terraform configuration bringing modules together
├── ecs/                   # Terraform module for ECS resources: cluster, tasks, services
│   ├── ecs.tf
│   ├── outputs.tf
│   └── variables.tf
└── vpc/                   # Terraform module for VPC and networking setup
    ├── outputs.tf
    ├── variables.tf
    └── vpc.tf


## Prerequisites

### AWS Account & Permissions

You’ll need:

- An **active AWS account** with permissions to create/modify:
  - VPC, subnets, route tables, internet/NAT gateways
  - Security groups
  - ECS clusters, services, task definitions
  - IAM roles and policies for ECS and networking

*Avoid using root credentials. Always use IAM users with strictly scoped permissions.*

### Installed Tools

- **Terraform** v0.13.0 (or newer)
- **AWS CLI** (recommended for credential handling)
- **Git** (for cloning this repo)

### Region and Resource Limits

- Ensure your AWS region supports the required resources.
- Validate that your account has sufficient service quotas.
- Avoid resource naming conflicts with any pre-existing infrastructure.

## Setup and Usage

### Clone the Repository


git clone https://github.com/bhaskarabommu/ecs-deployment.git
cd ecs-deployment


### Configure Variables

Before running Terraform, customize variables in:

- `ecs/variables.tf`
- `vpc/variables.tf`
- Or, use a personal `terraform.tfvars` file.

Typical variables to tailor include:

- VPC CIDR block
- ECS cluster name
- Container image URIs, task definitions
- Tags and scaling options

### Initialize Terraform


terraform init


This will download required providers and set up the backend.

### Preview Infrastructure Changes


terraform plan


**Carefully review** the output to confirm which resources will be created, changed, or destroyed.

### Apply Infrastructure


terraform apply


Follow the prompt and enter `yes` to proceed with deployment.

### Destroy Infrastructure

**To clean up all resources:**


terraform destroy


## Best Practices & Recommendations

- **Test** deployments in a non-production AWS account first.
- Use **Terraform workspaces** or unique state backends for different environments (dev, test, prod).
- Store your Terraform state remotely (e.g., **S3 with DynamoDB locking**) for safety and collaboration.
- Regularly **monitor AWS usage and costs**—resources like NAT gateways and Fargate services incur charges.
- Never commit AWS credentials or sensitive values to source control.
- Apply IAM **least-privilege principles**; prefer roles over users where possible.

## Additional Resources

- [AWS Elastic Container Service Documentation](https://docs.aws.amazon.com/ecs/latest/developerguide/what-is-ecs.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [HashiCorp Terraform Documentation](https://www.terraform.io/docs)

*Read and understand all Terraform configurations and their effects for your AWS environment before applying any changes to avoid unintended costs or security consequences.*
