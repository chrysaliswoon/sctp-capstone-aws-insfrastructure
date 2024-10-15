data "aws_iam_role" "lambda_data_process" {
  name = "ce6-group3-process-data-role-0dm6lrbw"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "app.py"
  output_path = "lambda_function_process_data-${var.env}.zip"
}

resource "aws_lambda_function" "process_data" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_process_data-${var.env}.zip"
  function_name = "ce6-capstone-group3-process-data-${var.env}"
  role          = data.aws_iam_role.lambda_data_process.arn
  memory_size   = var.lambda_mem
  timeout       = var.lambda_timeout
  layers        = ["arn:aws:lambda:ap-southeast-1:336392948345:layer:AWSSDKPandas-Python310:20"]
  handler       = "app.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

}

resource "aws_lambda_permission" "event_bridge" {

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_data.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn

}