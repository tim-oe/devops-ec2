terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# creds loaded via cli configs?
provider "aws" {
  profile    = "default"
}

# launch ec2 instance
resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"

  root_block_device {
    delete_on_termination = true
    volume_size = 16
    volume_type = "gp2"
  }

  tags = {
    Name ="${var.instance_name}"
    Environment = "prodution"
    Terraform   = "true"
    OS = "UBUNTU"
  }
} 

# secondary drive
resource "aws_ebs_volume" "secondary_ebs" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size = 16
  type = "gp2"
  tags = {
    Name = "${var.instance_name} secondary"
    Environment = "prodution"
    Terraform   = "true"
  }
}

resource "aws_volume_attachment" "single_ec2_ebs_att" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.secondary_ebs.id
  instance_id  = aws_instance.ec2_instance.id
  force_detach = true
}