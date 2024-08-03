
variable "my_region" {
  description = "Aws region to use on deployments"
  default = "us-east-1"
  type = string
}

variable "my_profile" {
  description = "Aws profile used to get the credentials"
  default = "default"
  type = string
}

variable "environment" {
  description = "Environment name, example: DEV or PROD"
  default = "DEV"
  type = string
}

variable "vpc_cidr" {
  description = "A network address space needed to create the vpc"
  default = "10.10.0.0/16"
  type = string
}

variable "ssh_public_key_path" {
  description = "SSH RSA public key path, used to create a keypair in aws to connect to remote vm using ssh."
  default = "C:\\Users\\Alex\\.ssh\\id_rsa.pub"
  type = string
}
