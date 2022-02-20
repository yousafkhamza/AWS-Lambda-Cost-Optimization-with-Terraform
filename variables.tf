variable "aws_region" {
  type        = string
  description = "Which region do you used"
  default     = ""
}

variable "type" {
  type        = string
  description = "Which instance type do you need"
  default     = "t2.micro"
}

variable "vol_size" {
  type        = string
  description = "Instance volume size do you need"
  default     = "8"
}

variable "start_cron" {
  type        = string
  description = "Cron time start the instance which we created"
  default     = "cron(0 9 * * ? *)"
}

variable "stop_cron" {
  type        = string
  description = "Cron time stop the instance which we created"
  default     = "cron(0 17 * * ? *)"
}

variable "ec2_tag" {
  type        = string
  description = "TAG for ec2 and this tag to take stop start this instance"
  default     = "python-terraform"
}

locals {
start_lambda_function = "start-lambda-function"
stop_lambda_function = "stop-lambda-function"
runtime_lambda_function = "python3.9"
}
