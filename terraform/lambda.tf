data "archive_file" "lambda_pwgen" {
  type        = "zip"
  source_dir  = "${path.module}/code"
  output_path = "${path.module}/releases/pwgen.zip"
}

resource "random_pet" "s3_pwgen_name" {
  prefix = "btmn-lambda"
  length = 2
}

resource "aws_s3_bucket" "s3_pwgen" {
  bucket        = random_pet.s3_pwgen_name.id
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_object" "pwgen" {
  bucket = aws_s3_bucket.s3_pwgen.id
  key    = "pwgen_py.zip"
  source = data.archive_file.lambda_pwgen.output_path
  etag   = filemd5(data.archive_file.lambda_pwgen.output_path)
}

resource "aws_lambda_function" "pwgen_py" {
  function_name = "pwgen-test"
  s3_bucket     = aws_s3_bucket.s3_pwgen.id
  s3_key        = aws_s3_bucket_object.pwgen.key
  runtime       = "python3.8"
  handler       = "app.lambda_handler"

  source_code_hash = data.archive_file.lambda_pwgen.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_permission" "apiv2" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pwgen_py.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.pwgen.execution_arn}/*/*"
}
