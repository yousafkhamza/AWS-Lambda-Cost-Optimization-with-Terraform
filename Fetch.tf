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
# Amazon linux AMI choosing through data resource
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


