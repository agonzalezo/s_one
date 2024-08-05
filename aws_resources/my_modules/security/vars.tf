## Data sources

## Variables
variable "my_vpc_id" {
  description = "VPC ID"
}

variable "my_vpc_cidr" {
  description = "VPC ID"
}

variable "environment" {
  description = "Environment"
}

variable "ssh_pub_path" {
  description = "Path where is located the ssh public key"
  default = "C:\\Users\\Alex\\.ssh\\id_rsa.pub"
}