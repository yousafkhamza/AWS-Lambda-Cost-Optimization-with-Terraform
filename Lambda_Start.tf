# ----------------------------------
# Lambda_Function
# ----------------------------------
#archiving py file to zip
data "archive_file" "start_lambda_zip" {
  type        = "zip"
  source_dir  = "./lambda_code/start/"
  output_path = "tmp/${local.start_lambda_function}.zip"
}

resource "aws_lambda_function" "ec2_start_lambda_function" {
  filename      = data.archive_file.start_lambda_zip.output_path
  function_name = "ec2-start-lambda-function"
  role          = aws_iam_role.lambda_iam_role_terraform.arn
  description   = "This lambda using to start the ec2 instance which we mentioned"
  handler       = "lambda_function.lambda_handler"
  runtime       = local.runtime_lambda_function
  timeout       = 60
  memory_size   = 128

  environment {
    variables = {
      REGION = var.aws_region
      TAG = var.ec2_tag
    }
  }

  tags = tomap({"Name" = "ec2 start lambda function"})
}


#-----------------------
# CloudWatch Trigger to start ec2 instance
#-----------------------
resource "aws_cloudwatch_event_rule" "trigger_to_start_ec2_instance" {
  name                  = "Trigger-start-ec2-instance-lambda"
  description           = "Trigger that moving data lambda"
  schedule_expression   = var.start_cron
  tags = tomap({"Name" = "ec2 start cloudwatch trigger"})

  depends_on = [aws_lambda_function.ec2_start_lambda_function]
}

resource "aws_cloudwatch_event_target" "send_to_start_lambda_target" {
  rule      = aws_cloudwatch_event_rule.trigger_to_start_ec2_instance.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.ec2_start_lambda_function.arn

  depends_on = [aws_lambda_function.ec2_start_lambda_function]
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.ec2_start_lambda_function.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.trigger_to_start_ec2_instance.arn

    depends_on = [aws_lambda_function.ec2_start_lambda_function,aws_cloudwatch_event_rule.trigger_to_start_ec2_instance]
}
