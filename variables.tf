variable "instance_name" {
        description = "Name of the instance to be created"
        default = "prod-app-99"
}

variable "instance_type" {
        description = "aws instance type"
        default = "t3.large"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-3889f75c"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-03f65b8614a860c29"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}


variable "ami_key_pair_name" {
        description = "the auth key pair to use for the instance"
        default = "devops-prod-us-west-2"
}

