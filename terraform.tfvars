aws_region = "ap-south-1"            # mention which region you need here.
type = "t2.micro"                    # mention which type of instance would you need and mention here.
vol_size = "10"                      # EC2 instance volume size mention here.
start_cron = "cron(0 8 * * ? *)"     # Which time to start that EC2 instance here.
stop_cron = "cron(0 16 * * ? *)"     # Which time to stop that EC2 instance here.
ec2_tag = "python-terraform"         # Tag for EC2 instance here and this tag is using to stop that EC2 instance so please be uniq
password_for_ec2 = "T36r@f06m@YKH"   # Strong password mentioned here for EC2 because we didn't use key pair if you need please login to the EC2 and do it manually
