aws_region = "ap-south-1"
type = "t2.micro"
vol_size = "10"
start_cron = "cron(0 8 * * ? *)"
stop_cron = "cron(0 16 * * ? *)"
ec2_tag = "python-terraform"