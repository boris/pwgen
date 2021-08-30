resource "aws_cloudwatch_log_group" "pwgen_lambda" {
  name = "/aws/lambda/${aws_lambda_function.pwgen_py.function_name}"

  retention_in_days = 7
}
