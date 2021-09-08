resource "aws_cloudwatch_log_group" "pwgen_lambda" {
  name = "/aws/lambda/${aws_lambda_function.pwgen_py.function_name}"

  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.pwgen.name}"

  retention_in_days = 7
}
