resource "aws_api_gateway_rest_api" "pwgen_rest" {
  name = "serverless_pwgen_rest"
}

resource "aws_api_gateway_resource" "pwgen_rest" {
  rest_api_id = aws_api_gateway_rest_api.pwgen_rest.id
  parent_id   = aws_api_gateway_rest_api.pwgen_rest.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "pwgen_rest" {
  rest_api_id   = aws_api_gateway_rest_api.pwgen_rest.id
  resource_id   = aws_api_gateway_resource.pwgen_rest.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.pwgen_rest.id
  resource_id = aws_api_gateway_method.pwgen_rest.resource_id
  http_method = aws_api_gateway_method.pwgen_rest.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.pwgen_py.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.pwgen_rest.id
  resource_id   = aws_api_gateway_rest_api.pwgen_rest.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.pwgen_rest.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.pwgen_py.invoke_arn
}

resource "aws_api_gateway_deployment" "pwgen_rest" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.pwgen_rest.id
  stage_name  = "test"
}
