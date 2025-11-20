# Outputs for mrad-webcore-lmdbsched module

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.dbsched_lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.dbsched_lambda.lambda_arn
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

output "friday_event_rule_arn" {
  description = "ARN of the Friday CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.dbsched_friday.arn
}

output "monday_event_rule_arn" {
  description = "ARN of the Monday CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.dbsched_monday.arn
}

