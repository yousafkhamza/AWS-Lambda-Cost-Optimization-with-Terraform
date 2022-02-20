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
  user_data 				           = file("userdata.sh")
  tags                         = {
    Name                      = var.ec2_tag
  }

  root_block_device            {
  volume_type                   = "gp2"
  volume_size                   = var.vol_size
  }
}