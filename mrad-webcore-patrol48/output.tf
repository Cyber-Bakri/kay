# Outputs for mrad-webcore-patrol48 module

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.patrol48_lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.patrol48_lambda.lambda_arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_role_name" {
  description = "Name of the Lambda execution role"
  value       = aws_iam_role.lambda_role.name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.lambda_logs.cloudwatch_log_group_name
}

output "schedule_event_rule_arn" {
  description = "ARN of the 48-hour schedule CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.patrol48_schedule.arn
}

