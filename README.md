# AWS-Lambda-Cost-Optimization-with-Terraform

[![Build](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

---
## Description
This is a terraform script for cost optimization using lambda. So, this script can set up a cron(schedule) to start and stop ec2 servers. So, if we need to work a server like an office time like 9:00 AM to 7:00 PM then we can save our time and effort to do this thing manually.

----
## Feature
- We can save billing money  
- Automated with CloudWatch
- EC2 instance with root password (if you need key based please enable that after creation)

----
## Architecture
![](lambda_code/screenshots/flow_architecture.jpg)

----
## Services Created

- EC2
- Security Group
- IAM Role (Custom Inline Policies for lambda)
- Lambda Functions
- Cloudwatch Event Rule Trigger

----
## Pre-Requests
- Terraform
- Git

#### Terraform Installation
[Terraform Installation from official](https://www.terraform.io/downloads)

_Terrafom Installation from my script:_
```
curl -Ls https://raw.githubusercontent.com/yousafkhamza/Terraform_installation/main/terraform.sh | bash
```

#### Pre-Requests (for RedHat-based-Linux)
```
yum install -y git
```

#### Pre-Requests (for Debian-based-Linux)
````
apt install -y git
````

#### Pre-Requests (for Termux-based-Linux)
````
pkg upgrade
pkg install git
````

---
## How to Get
```
git clone https://github.com/yousafkhamza/AWS-Lambda-Cost-Optimization-with-Terraform.git
cd AWS-Lambda-Cost-Optimization-with-Terraform.git
```

----
## How to execute
```
terraform init
terraform plan
terraform apply
```

----
## Output be like
```
 terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_cloudwatch_event_rule.trigger_to_start_ec2_instance will be created
  + resource "aws_cloudwatch_event_rule" "trigger_to_start_ec2_instance" {
      + arn                 = (known after apply)
      + description         = "Trigger that moving data lambda"
      + event_bus_name      = "default"
      + id                  = (known after apply)
      + is_enabled          = true
      + name                = "Trigger-start-ec2-instance-lambda"
      + name_prefix         = (known after apply)
      + schedule_expression = "cron(0 8 * * ? *)"
      + tags                = {
          + "Name" = "ec2 start cloudwatch trigger"
        }
      + tags_all            = {
          + "Name" = "ec2 start cloudwatch trigger"
        }
    }

  # aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance will be created
  + resource "aws_cloudwatch_event_rule" "trigger_to_stop_ec2_instance" {
      + arn                 = (known after apply)
      + description         = "Trigger that moving data lambda"
      + event_bus_name      = "default"
      + id                  = (known after apply)
      + is_enabled          = true
      + name                = "Trigger-stop-ec2-instance-lambda"
      + name_prefix         = (known after apply)
      + schedule_expression = "cron(0 16 * * ? *)"
      + tags                = {
          + "Name" = "ec2 stop cloudwatch trigger"
        }
      + tags_all            = {
          + "Name" = "ec2 stop cloudwatch trigger"
        }
    }

  # aws_cloudwatch_event_target.send_to_start_lambda_target will be created
  + resource "aws_cloudwatch_event_target" "send_to_start_lambda_target" {
      + arn            = (known after apply)
      + event_bus_name = "default"
      + id             = (known after apply)
      + rule           = "Trigger-start-ec2-instance-lambda"
      + target_id      = "SendToLambda"
    }

  # aws_cloudwatch_event_target.send_to_stop_lambda_target will be created
  + resource "aws_cloudwatch_event_target" "send_to_stop_lambda_target" {
      + arn            = (known after apply)
      + event_bus_name = "default"
      + id             = (known after apply)
      + rule           = "Trigger-stop-ec2-instance-lambda"
      + target_id      = "SendToLambda"
    }

  # aws_iam_role.lambda_iam_role_terraform will be created
  + resource "aws_iam_role" "lambda_iam_role_terraform" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "IAM role for lambda to stop start that instance which we created"
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "Lambda-IAM-Role-For-EC2-Stop-Start"
      + name_prefix           = (known after apply)
      + path                  = "/lambda/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = "EC2-Describe-Inline-Policy"
          + policy = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action   = "ec2:DescribeInstances"
                          + Effect   = "Allow"
                          + Resource = "*"
                          + Sid      = ""
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
        }
      + inline_policy {
          + name   = "EC2-Stop-Start-Inline-Policy"
          + policy = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action   = [
                              + "ec2:StopInstances",
                              + "ec2:StartInstances",
                            ]
                          + Effect   = "Allow"
                          + Resource = "arn:aws:ec2:ap-south-1:361738388880:instance/*"
                          + Sid      = ""
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
        }
    }

  # aws_instance.ec2_instance will be created
  + resource "aws_instance" "ec2_instance" {
      + ami                                  = "ami-0dafa01c8100180f8"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = "ap-south-1a"
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = "subnet-0ee7a1d09074c3e0b"
      + tags                                 = {
          + "Name" = "python-terraform"
        }
      + tags_all                             = {
          + "Name" = "python-terraform"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "3f970a9f1a5d611c3764c372fc96f2c681039d94"
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 10
          + volume_type           = "gp2"
        }
    }

  # aws_lambda_function.ec2_start_lambda_function will be created
  + resource "aws_lambda_function" "ec2_start_lambda_function" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + description                    = "This lambda using to start the ec2 instance which we mentioned"
      + filename                       = "tmp/start-lambda-function.zip"
      + function_name                  = "ec2-start-lambda-function"
      + handler                        = "lambda_function.lambda_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "python3.9"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = (known after apply)
      + source_code_size               = (known after apply)
      + tags                           = {
          + "Name" = "ec2 start lambda function"
        }
      + tags_all                       = {
          + "Name" = "ec2 start lambda function"
        }
      + timeout                        = 60
      + version                        = (known after apply)

      + environment {
          + variables = {
              + "REGION" = "ap-south-1"
              + "TAG"    = "python-terraform"
            }
        }

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # aws_lambda_function.ec2_stop_lambda_function will be created
  + resource "aws_lambda_function" "ec2_stop_lambda_function" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + description                    = "This lambda using to stop the ec2 instance which we mentioned"
      + filename                       = "tmp/stop-lambda-function.zip"
      + function_name                  = "ec2-stop-lambda-function"
      + handler                        = "lambda_function.lambda_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "python3.9"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = (known after apply)
      + source_code_size               = (known after apply)
      + tags                           = {
          + "Name" = "ec2 stop lambda function"
        }
      + tags_all                       = {
          + "Name" = "ec2 stop lambda function"
        }
      + timeout                        = 60
      + version                        = (known after apply)

      + environment {
          + variables = {
              + "REGION" = "ap-south-1"
              + "TAG"    = "python-terraform"
            }
        }

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # aws_lambda_permission.allow_cloudwatch_to_call_start_lambda will be created
  + resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_lambda" {
      + action        = "lambda:InvokeFunction"
      + function_name = "ec2-start-lambda-function"
      + id            = (known after apply)
      + principal     = "events.amazonaws.com"
      + source_arn    = (known after apply)
      + statement_id  = "AllowExecutionFromCloudWatch"
    }

  # aws_lambda_permission.allow_cloudwatch_to_call_stop_lambda will be created
  + resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_lambda" {
      + action        = "lambda:InvokeFunction"
      + function_name = "ec2-stop-lambda-function"
      + id            = (known after apply)
      + principal     = "events.amazonaws.com"
      + source_arn    = (known after apply)
      + statement_id  = "AllowExecutionFromCloudWatch"
    }

  # aws_security_group.sg_for_ec2 will be created
  + resource "aws_security_group" "sg_for_ec2" {
      + arn                    = (known after apply)
      + description            = "Allow 80,443,22"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS"
              + from_port        = 443
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS"
              + from_port        = 80
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "sgec2"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "sg-for-stop-start-ec2"
        }
      + tags_all               = {
          + "Name" = "sg-for-stop-start-ec2"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 11 to add, 0 to change, 0 to destroy.
aws_iam_role.lambda_iam_role_terraform: Creating...
aws_security_group.sg_for_ec2: Creating...
aws_security_group.sg_for_ec2: Creation complete after 4s [id=sg-01e05ef2f174955f7]
aws_instance.ec2_instance: Creating...
aws_iam_role.lambda_iam_role_terraform: Creation complete after 5s [id=Lambda-IAM-Role-For-EC2-Stop-Start]
aws_lambda_function.ec2_start_lambda_function: Creating...
aws_lambda_function.ec2_stop_lambda_function: Creating...
aws_instance.ec2_instance: Still creating... [10s elapsed]
aws_lambda_function.ec2_start_lambda_function: Still creating... [10s elapsed]
aws_lambda_function.ec2_stop_lambda_function: Still creating... [10s elapsed]
aws_lambda_function.ec2_stop_lambda_function: Creation complete after 11s [id=ec2-stop-lambda-function]
aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance: Creating...
aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance: Creation complete after 1s [id=Trigger-stop-ec2-instance-lambda]
aws_lambda_permission.allow_cloudwatch_to_call_stop_lambda: Creating...
aws_cloudwatch_event_target.send_to_stop_lambda_target: Creating...
aws_cloudwatch_event_target.send_to_stop_lambda_target: Creation complete after 0s [id=Trigger-stop-ec2-instance-lambda-SendToLambda]
aws_lambda_permission.allow_cloudwatch_to_call_stop_lambda: Creation complete after 0s [id=AllowExecutionFromCloudWatch]
aws_lambda_function.ec2_start_lambda_function: Creation complete after 16s [id=ec2-start-lambda-function]
aws_cloudwatch_event_rule.trigger_to_start_ec2_instance: Creating...
aws_cloudwatch_event_rule.trigger_to_start_ec2_instance: Creation complete after 1s [id=Trigger-start-ec2-instance-lambda]
aws_lambda_permission.allow_cloudwatch_to_call_start_lambda: Creating...
aws_cloudwatch_event_target.send_to_start_lambda_target: Creating...
aws_cloudwatch_event_target.send_to_start_lambda_target: Creation complete after 0s [id=Trigger-start-ec2-instance-lambda-SendToLambda]
aws_lambda_permission.allow_cloudwatch_to_call_start_lambda: Creation complete after 0s [id=AllowExecutionFromCloudWatch]
aws_instance.ec2_instance: Still creating... [20s elapsed]
aws_instance.ec2_instance: Still creating... [30s elapsed]
aws_instance.ec2_instance: Creation complete after 33s [id=i-07d44771b790189bc]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.
```
### _Output Screenshots (at AWS)_
![](lambda_code/screenshots/1.png)
![](lambda_code/screenshots/2.png)
![](lambda_code/screenshots/3.png)
![](lambda_code/screenshots/4.png)

----
## Behind the code
### Terraform code
_EC2.tf_
````
#-----------------------
# EC2 Instance
#-----------------------

resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.linux.id
  instance_type               = var.type
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.available.names[0]
#  key_name                    = var.key  #we are using password through userdata once you logged in please change on be half of you!
  subnet_id                   = tolist(data.aws_subnets.my_vpc.ids)[0]
  vpc_security_group_ids      = [ aws_security_group.sg_for_ec2.id ]
  user_data 				           = <<EOF
#!/bin/bash
echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
echo "LANG=en_US.utf-8" >> /etc/environment
echo "LC_ALL=en_US.utf-8" >> /etc/environment
echo "${var.password_for_ec2}" | passwd root --stdin
sed  -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service sshd restart
EOF
  tags                         = {
    Name                      = var.ec2_tag
  }

  root_block_device            {
  volume_type                   = "gp2"
  volume_size                   = var.vol_size
  }
}
````
> Userdata including this file due to the password fetching through as a variable. and creating an ec2 instance with your requirements and you can set those variables like "Instance type, Volume Size, Tag for lambda, Password for the ec2 instance" so you can choose those strings values as a variable in `terraform.tfvars`.

_SG.tf_
```
# -------------------------------------
# Security Group
# -------------------------------------

resource "aws_security_group" "sg_for_ec2" {
  name        = "sgec2"
  description = "Allow 80,443,22"
  
  ingress {
    description      = "HTTPS"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-for-stop-start-ec2"
  }
    lifecycle {
    create_before_destroy = true
  }
}
```
> Security group for EC2 server which we created through the script and this Security group allowed HTTP, HTTPS, SSH.

_Fetch.tf_
```
# Fetch Account ID for IAM.
data "aws_caller_identity" "current" {
}

# Fetch Default VPC 
data "aws_vpc" "default" {
    default = true
}

# AZ Fetching 
data "aws_availability_zones" "available" {
  state = "available"
}

# Subnet Fetching
data "aws_subnets" "my_vpc" {
  filter {
    name   = "vpc-id"
    values = [ data.aws_vpc.default.id ]
  }
}


#------------------------------------------------------
# Amazon Linux AMI choosing through data resource
#------------------------------------------------------
data "aws_ami" "linux" {
  most_recent = true

   filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
owners = ["137112412989"] # Canonical
}
```
> Fetching all the details ie. amazon Linux AMI for all-region, current account ID for creating IAM Role security and we are using default VPC to create the EC2 so which we fetched data for instance creation which of those fetching services like those VPC, Availability zone, Subnet

_IAM.tf_
```
# ----------------------------------
# IAM Role for Lambda Function 
# ----------------------------------
# Assume Role - For Lambda
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = [
    "sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
      "lambda.amazonaws.com"]
    }
  }
}

# Inline policy for ec2 stop start for lambda
data "aws_iam_policy_document" "ec2_stop_start_inline_policy" {
  statement {
    actions = [
        "ec2:StartInstances",
        "ec2:StopInstances",
    ]
    resources = [
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
  }
}

data "aws_iam_policy_document" "ec2_describe_inline_policy" {
  statement {
    actions = [
     "ec2:DescribeInstances"
    ]
    resources = [
        "*"
      ]
  }
}

# Role for Lambda and both assume and inline integrated 
resource "aws_iam_role" "lambda_iam_role_terraform" {
  name               = "Lambda-IAM-Role-For-EC2-Stop-Start"
  path               = "/lambda/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  description = "IAM role for lambda to stop-start that instance which we created"

  inline_policy {
    name   = "EC2-Stop-Start-Inline-Policy"
    policy = data.aws_iam_policy_document.ec2_stop_start_inline_policy.json
  }
    inline_policy {
    name   = "EC2-Describe-Inline-Policy"
    policy = data.aws_iam_policy_document.ec2_describe_inline_policy.json
  }
}
```
> I have created an IAM role for lambda execution and we are using the most secure IAM to run that lambda and lock with the Account ID and Region

_Lambda_Start.tf_
```
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
```
> Creating a lambda function with ec2 instance starting python script and the scheduler cloudwatch (so you can choose the cron time as a variable in `terraform.tfvars`)

_Lambda_Stop.tf_
```
# ----------------------------------
# Lambda_Function
# ----------------------------------
#archiving py file to zip
data "archive_file" "stop_lambda_zip" {
  type        = "zip"
  source_dir  = "./lambda_code/stop/"
  output_path = "tmp/${local.stop_lambda_function}.zip"
}

resource "aws_lambda_function" "ec2_stop_lambda_function" {
  filename      = data.archive_file.stop_lambda_zip.output_path
  function_name = "ec2-stop-lambda-function"
  role          = aws_iam_role.lambda_iam_role_terraform.arn
  description   = "This lambda using to stop the ec2 instance which we mentioned"
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

  tags = tomap({"Name" = "ec2 stop lambda function"})
}


#-----------------------
# CloudWatch Trigger to stop ec2 instance
#-----------------------
resource "aws_cloudwatch_event_rule" "trigger_to_stop_ec2_instance" {
  name                  = "Trigger-stop-ec2-instance-lambda"
  description           = "Trigger that moving data lambda"
  schedule_expression   = var.stop_cron
  tags = tomap({"Name" = "ec2 stop cloudwatch trigger"})

  depends_on = [aws_lambda_function.ec2_stop_lambda_function]
}

resource "aws_cloudwatch_event_target" "send_to_stop_lambda_target" {
  rule      = aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.ec2_stop_lambda_function.arn

  depends_on = [aws_lambda_function.ec2_stop_lambda_function]
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.ec2_stop_lambda_function.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance.arn

    depends_on = [aws_lambda_function.ec2_stop_lambda_function,aws_cloudwatch_event_rule.trigger_to_stop_ec2_instance]
}
```
> Creating a lambda function with ec2 instance starting python script and the scheduler cloudwatch (so you can choose the cron time as a variable in `terraform.tfvars`) 

_variables.tf_
```
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

variable "password_for_ec2" {
  type        = string
  description = "Password for EC2 Server"
  default     = "T36r@f06m@YKH"
}

locals {
start_lambda_function = "start-lambda-function"
stop_lambda_function = "stop-lambda-function"
runtime_lambda_function = "python3.9"
}
```
> Variables name defining here and I have set up some predefined and default values here. you can change all the variable values on `terraform.tfvars`

_terraform.tfvars_
```
aws_region = "ap-south-1"            # mention which region you need here.
type = "t2.micro"                    # mention which type of instance would you need and mention here.
vol_size = "10"                      # EC2 instance volume size mention here.
start_cron = "cron(0 8 * * ? *)"     # Which time to start that EC2 instance here.
stop_cron = "cron(0 16 * * ? *)"     # Which time to stop that EC2 instance here.
ec2_tag = "python-terraform"         # Tag for EC2 instance here and this tag is using to stop that EC2 instance so please be uniq
password_for_ec2 = "T36r@f06m@YKH"   # Strong password mentioned here for EC2 because we didn't use key pair if you need please login to the EC2 and do it manually
```
> **Please read the side notes and change the values as you need like the left side. if you're not changing it will run with those default values so please change it manually before running `terraform apply`**

### Python Code
_lambda_code/start/lambda_function.py_
```
import boto3
import os

REGION = os.environ['REGION']
TAG = os.environ['TAG']

def lambda_handler(event, context):
    ec2 = boto3.client('ec2',region_name=REGION)
    all_ec2 = ec2.describe_instances(
        Filters=[
        {'Name':'tag:Name', 'Values':[TAG]}
        ])

    for instance in all_ec2['Reservations'][0]['Instances']:
        print("Starting Ec2 : {} ".format( instance['InstanceId'] ))
        ec2.start_instances(InstanceIds=[ instance['InstanceId'] ])
```
> Using environment variables to fetch that tag and region details from variable and so this is used to start that ec2 instance which we created with this script.

_lambda_code/stop/lambda_function.py_
```
import boto3
import os

REGION = os.environ['REGION']
TAG = os.environ['TAG']

def lambda_handler(event, context):
    ec2 = boto3.client('ec2',region_name=REGION)
    all_ec2 = ec2.describe_instances(
        Filters=[
        {'Name':'tag:Name', 'Values':[TAG]}
        ])

    for instance in all_ec2['Reservations'][0]['Instances']:
        print("Stopping Ec2 : {} ".format( instance['InstanceId'] ))
        ec2.stop_instances(InstanceIds=[ instance['InstanceId'] ])
```
> Using environment variables to fetch that tag and region details from variable and so this is used to stop that ec2 instance which we created with this script.

----
## Conclusion
Q: I would like to start and stop an EC2 instance automatically and it's saving cost and time. Also, please create an instance with my wish. So, is it possible?

A: Yeah sure, we can do this with lambda and cloudwatch and you can create an ec2 instance with your required values as you wish. Also, those values can only change through in `terraform.tfvars` so, after it will be automated on rest of time.

### ⚙️ Connect with Me 

<p align="center">
<a href="mailto:yousaf.k.hamza@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"/></a>
<a href="https://www.linkedin.com/in/yousafkhamza"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/></a> 
<a href="https://www.instagram.com/yousafkhamza"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/></a>
<a href="https://wa.me/%2B917736720639?text=This%20message%20from%20GitHub."><img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/></a><br />
