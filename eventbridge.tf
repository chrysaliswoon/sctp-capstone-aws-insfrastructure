resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name                = "trigger-lambda-data-process-${var.env}"
  description         = "Trigger lambda at a scheduled datetime"
  schedule_expression = "cron(00 14 * * ? *)"

}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger.name
  target_id = "lambda-process-data-target"
  arn       = aws_lambda_function.process_data.arn

}