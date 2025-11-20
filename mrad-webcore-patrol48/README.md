# mrad-webcore-patrol48

Terraform module for PATROL 48-hour Lambda deployment

## Description

This module deploys a Lambda function that runs every 48 hours as part of the PATROL DevOps pipeline. The Lambda is built and deployed with automatic scheduling via CloudWatch Events.

## Features

- ✅ Lambda function deployed from S3 bucket
- ✅ Runs automatically every 48 hours
- ✅ CloudWatch Logs integration
- ✅ SumoLogic monitoring and observability
- ✅ VPC integration with MRAD subnets
- ✅ Comprehensive IAM permissions
- ✅ Multi-environment support (Dev, QA, Prod)

## Usage

```hcl
module "patrol48" {
  source  = "app.terraform.io/pgetech/mrad-webcore-patrol48/aws"
  version = "0.0.1"

  providers = {
    aws       = aws
    github    = github
    sumologic = sumologic
  }

  prefix     = var.prefix
  suffix     = var.suffix
  git_branch = var.git_branch
  tags       = var.tags
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6 |
| aws | ~> 5.0 |
| github | >= 4.0 |
| archive | ~> 2.0 |
| random | ~> 3.0 |
| sumologic | ~> 2.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.0 |
| github | >= 4.0 |
| sumologic | ~> 2.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix for resource names | `string` | n/a | yes |
| suffix | Environment suffix (Dev, QA, Prod) | `string` | n/a | yes |
| git_branch | Git branch name for deployment tracking | `string` | n/a | yes |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_function_name | Name of the Lambda function |
| lambda_function_arn | ARN of the Lambda function |
| lambda_role_arn | ARN of the Lambda execution role |
| lambda_role_name | Name of the Lambda execution role |
| cloudwatch_log_group_name | Name of the CloudWatch log group |
| schedule_event_rule_arn | ARN of the 48-hour schedule CloudWatch event rule |

## Schedule

The Lambda runs on a **48-hour schedule** using CloudWatch Events with the expression:
```
rate(48 hours)
```

## Resources Created

- AWS Lambda function
- IAM role and policy for Lambda execution
- CloudWatch Event Rule (48-hour schedule)
- CloudWatch Event Target
- Lambda permission for CloudWatch Events
- CloudWatch Log Group
- SumoLogic integration

## Notes

- Lambda code must be uploaded to S3 bucket: `webcore-patrol-{env}-lambdas`
- Lambda ZIP file name: `PATROL-48hr-Lambda.zip`
- Requires SHA256 checksum for S3 object
- Uses MRAD VPC subnets and security groups

## License

Proprietary - PGE Tech

