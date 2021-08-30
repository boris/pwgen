output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.pwgen_py.function_name
}

output "s3_deployment_bucket" {
  description = "Name of the S3 deployment bucket."
  value       = aws_s3_bucket.s3_pwgen.id
}

output "base_url" {
  description = "Base URL for API Gateway stage."
  value       = aws_apigatewayv2_stage.pwgen.invoke_url
}
