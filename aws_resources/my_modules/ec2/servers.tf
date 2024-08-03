# resource "aws_instance" "web_server" {
#   for_each = {for index, subnet in var.public_subnet_ids : index => subnet.id }
#   ami               = data.aws_ami.linux_ami_os.id
#   instance_type     = var.instance_type
#   key_name          = "${var.environment}_ssh_key"
#   tags = {
#     "Name" : "${var.environment}-${each.key}-web_server"
#   }
#   subnet_id              = each.value
#   vpc_security_group_ids = [var.security_group_id]

#   #User data is limited to 16 KB
#   user_data = file("C:\\Users\\Alex\\Documents\\Ares\\Developer\\Iac\\terraform\\aws\\modules\\ec2\\userData.sh")
# }

resource "aws_instance" "web_server" {
  for_each      = { for index, subnet in var.public_subnet_ids : index => subnet.id }
  ami           = data.aws_ami.linux_ami_os.id
  instance_type = var.instance_type
  key_name      = "${var.environment}_ssh_key"
  tags = {
    "Name" : "${var.environment}-${each.key}-web_server"
  }
  subnet_id              = each.value
  vpc_security_group_ids = [var.security_group_id]

  #User data is limited to 16 KB
  user_data = <<-EOF
                #!/bin/bash
                # ---> Updating, upgrating and installing the base
                sudo apt update && apt upgrade -y
                sudo apt install python3-pip apt-transport-https ca-certificates curl software-properties-common zip unzip -y
                sudo su - root -c 'mkdir -p /opt/software_one && chown ubuntu:ubuntu /opt/software_one'
                cd /opt/software_one && wget https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip
                cd /opt/software_one && unzip main.zip
                EOF
}

resource "aws_instance" "database_server" {
  ami           = data.aws_ami.windows_ami_os.id
  instance_type = var.instance_type
  key_name      = "${var.environment}_ssh_key"
  tags = {
    "Name" : "${var.environment}-database_server"
  }
  subnet_id              = var.public_subnet_ids[1].id
  vpc_security_group_ids = [var.security_group_id]

  #User data is limited to 16 KB
  user_data = <<-EOF
                <powershell>
                # Set the execution policy to allow the script to run
                Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

                # Install Windows Features (example: Web-Server)
                # Install-WindowsFeature -Name Web-Server

                # Create a new directory and download the repo.
                New-Item -Path "C:\\software_one" -ItemType Directory
                Invoke-WebRequest https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip -OutFile "C:\\software_one/repo.zip"
                if (cd "C:\\software_one") { Expand-Archive .\repo.zip repo }

                # Habilitar WinRM
                winrm quickconfig -quiet
                winrm set winrm/config/service/auth @{Basic="true"}
                winrm set winrm/config/service @{AllowUnencrypted="true"}
                winrm set winrm/config/winrs @{MaxMemoryPerShellMB="1024"}
                winrm set winrm/config @{MaxTimeoutms="1800000"}
                </powershell>
                EOF
}
