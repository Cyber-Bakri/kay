# Terraform Modules - MRAD Webcore

This repository contains Terraform infrastructure configurations using MRAD webcore modules.

## Structure

```
.
├── main.tf                          # External main referencing lmdbsched module
├── main-patrol48.tf                 # External main referencing patrol48 module
├── variables.tf                     # Shared variables
├── variables-patrol48.tf            # PATROL48-specific variables
├── locals.tf                        # Local values
├── providers.tf                     # Provider configurations
├── README.md                        # This file
│
├── mrad-webcore-lmdbsched/         # Database Scheduler Module
│   ├── main.tf                     # Lambda + Friday/Monday schedules
│   ├── data.tf                     # Data sources
│   ├── iam.tf                      # IAM policies and roles
│   ├── locals.tf                   # Module local values
│   ├── variables.tf                # Module input variables
│   ├── output.tf                   # Module outputs
│   ├── terraform.tf                # Terraform requirements
│   ├── CHANGELOG.md                # Module changelog
│   ├── README.md                   # Module documentation
│   └── module.info                 # Module information
│
└── mrad-webcore-patrol48/          # PATROL 48-hour Lambda Module
    ├── main.tf                     # Lambda + 48-hour schedule
    ├── data.tf                     # Data sources
    ├── iam.tf                      # IAM policies and roles
    ├── locals.tf                   # Module local values
    ├── variables.tf                # Module input variables
    ├── output.tf                   # Module outputs
    ├── terraform.tf                # Terraform requirements
    ├── CHANGELOG.md                # Module changelog
    ├── README.md                   # Module documentation
    └── module.info                 # Module information
```

## Modules

### 1. mrad-webcore-lmdbsched (Database Scheduler)

**Purpose:** Deploys a Lambda function that stops databases over the weekend and restarts them on Monday.

**Schedule:**
- Friday 7pm PST (Saturday 2am UTC) - Stop databases
- Sunday 6pm PST (Monday 2am UTC) - Start databases

**Registry:**
```hcl
source  = "app.terraform.io/pgetech/mrad-webcore-lmdbsched/aws"
version = "0.0.13"
```

**Usage:** See `main.tf`

---

### 2. mrad-webcore-patrol48 (PATROL 48-hour Lambda)

**Purpose:** Deploys a Lambda function that runs every 48 hours as part of the PATROL DevOps pipeline.

**Schedule:**
- Runs every 48 hours automatically

**Registry:**
```hcl
source  = "app.terraform.io/pgetech/mrad-webcore-patrol48/aws"
version = "0.0.1"
```

**Usage:** See `main-patrol48.tf`

---

## Prerequisites

1. **AWS Credentials** configured
2. **Terraform >= 1.6** installed
3. **Required Providers:**
   - AWS (~> 5.0)
   - GitHub (>= 4.0)
   - SumoLogic (~> 2.6)
   - Archive (~> 2.0)
   - Random (~> 3.0)

## Quick Start

1. **Configure providers** in `providers.tf`

2. **Create `terraform.tfvars`:**
   ```hcl
   prefix           = "my-prefix"
   suffix           = "Dev"  # or QA, Prod
   git_branch       = "main"
   create_lmdbsched = true
   create_patrol48  = true
   
   tags = {
     Project     = "MRAD"
     Environment = "Dev"
     ManagedBy   = "Terraform"
   }
   ```

3. **Initialize and apply:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Module Usage Examples

### Using lmdbsched module:

```hcl
module "lmdbsched" {
  source  = "app.terraform.io/pgetech/mrad-webcore-lmdbsched/aws"
  version = "0.0.13"
  count   = var.create_lmdbsched ? 1 : 0

  providers = {
    aws       = aws
    github    = github
    sumologic = sumologic
  }

  prefix     = var.prefix
  git_branch = var.git_branch
  tags       = local.tags
}
```

### Using patrol48 module:

```hcl
module "patrol48" {
  source  = "app.terraform.io/pgetech/mrad-webcore-patrol48/aws"
  version = "0.0.1"
  count   = var.create_patrol48 ? 1 : 0

  providers = {
    aws       = aws
    github    = github
    sumologic = sumologic
  }

  prefix     = var.prefix
  suffix     = var.suffix
  git_branch = var.git_branch
  tags       = local.tags
}
```

## Environment Configuration

Both modules support three environments:
- **Dev:** Account ID `990878119577`
- **QA:** Account ID `471817339124`
- **Prod:** Account ID `712640766496`

Environment is automatically determined from AWS account ID.

## S3 Bucket Requirements

### lmdbsched:
- Bucket: `webcore-engage-{env}-lambdas`
- Key: `Engage-DB-Scheduler.zip`

### patrol48:
- Bucket: `webcore-patrol-{env}-lambdas`
- Key: `PATROL-48hr-Lambda.zip`

Both require SHA256 checksum via:
```bash
aws s3api put-object --bucket BUCKET --key KEY --body FILE --checksum-algorithm SHA256
```

## Outputs

Both modules provide outputs for:
- Lambda function name and ARN
- IAM role name and ARN
- CloudWatch log group name
- Event rule ARNs

## License

Proprietary - PGE Tech
