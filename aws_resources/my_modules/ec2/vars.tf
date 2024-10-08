data "aws_ami" "linux_ami_os" {
  most_recent = true
  owners = [ "amazon" ]
  # name_regex = "^Amazon Linux.*"
  name_regex = "^ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.*"

  filter {
    name = "architecture"
    values = [ "x86_64" ] # arm64
  }
}

data "aws_ami" "windows_ami_os" {
  most_recent = true
  owners = [ "amazon" ]
  ## Command to list images 
  ## aws ec2 describe-images --filters "Name=name,Values=Windows_Server-2022-Spanish-Full-Base*" --query "Images[*].[ImageId,Name]" --output text
  name_regex = "^Windows_Server-2022-Spanish-Full-Base*"

  filter {
    name = "architecture"
    values = [ "x86_64" ] # arm64
  }
}

## Variables
variable "security_group_id" {
  type = string
  description = "Security group id to associate with ec2"
}

variable "public_subnet_ids" {
  description = "Subnet ids to create ec2."
}

variable "ami_id" {
  description = "amazon linux image id"
  default = "ami-04a81a99f5ec58529" ## Ubuntu
  # default = "ami-0dfcb1ef8550277af" ## Amazon Linux
}

variable "instance_type" {
  description = "EC2 instance type."
  default     = "t3.medium"
}

variable "environment" {
  # default     = "DEV"
  description = "Environment name used as prefix / suffix"
}