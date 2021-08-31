output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.pwgen_py.function_name
}

output "s3_deployment_bucket" {
  description = "Name of the S3 deployment bucket."
  value       = aws_s3_bucket.s3_pwgen.id
}

output "base_url_rest" {
  description = "Base URL for API Gateway REST."
  value       = aws_api_gateway_deployment.pwgen_rest.invoke_url
}
