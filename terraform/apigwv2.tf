resource "aws_apigatewayv2_api" "pwgen" {
  name          = "serverless_pwgen_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "pwgen" {
  api_id      = aws_apigatewayv2_api.pwgen.id
  name        = "serverless_pwgen_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      status                  = "$context.status"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
}

resource "aws_apigatewayv2_integration" "pwgen" {
  api_id             = aws_apigatewayv2_api.pwgen.id
  integration_uri    = aws_lambda_function.pwgen_py.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "pwgen" {
  api_id    = aws_apigatewayv2_api.pwgen.id
  route_key = "GET /pass"
  target    = "integrations/${aws_apigatewayv2_integration.pwgen.id}"
}

resource "aws_apigatewayv2_integration" "foo" {
  api_id             = aws_apigatewayv2_api.pwgen.id
  integration_uri    = "arn:aws:lambda:us-east-1:111285186890:function:bitcoin-price"
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "foo" {
  api_id    = aws_apigatewayv2_api.pwgen.id
  route_key = "GET /btc"
  target    = "integrations/${aws_apigatewayv2_integration.foo.id}"
}
