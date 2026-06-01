resource "aws_s3_bucket" "assets" {
  bucket        = "bedrock-assets-${var.student_id}"
  force_destroy = true

  tags = merge(var.tags, {
    Name = "bedrock-assets-${var.student_id}"
  })
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.root}/../lambda/asset_processor.py"
  output_path = "${path.root}/../lambda/asset_processor.zip"
}

resource "aws_lambda_function" "asset_processor" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "bedrock-asset-processor"
  role             = var.lambda_role_arn
  handler          = "asset_processor.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = merge(var.tags, {
    Name = "bedrock-asset-processor"
  })
}

resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.asset_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.assets.arn
}

resource "aws_s3_bucket_notification" "assets_trigger" {
  bucket = aws_s3_bucket.assets.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.asset_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_trigger]
}
