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
                # ---> Updating, upgrading and installing the base
                sudo apt update && apt upgrade -y
                sudo apt install python3-pip apt-transport-https ca-certificates curl software-properties-common zip unzip -y
                sudo add-apt-repository --yes --update ppa:ansible/ansible
                sudo apt update
                sudo apt install ansible -y
                ansible --version
                sudo su - root -c 'mkdir -p /opt/software_one'
                cd /opt/software_one && wget https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip
                cd /opt/software_one && unzip main.zip
                chown -R ubuntu:ubuntu /opt/software_one
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
                Invoke-WebRequest https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip -OutFile "C:\\software_one/main.zip"
                cd "C:\\software_one"; Expand-Archive .\main.zip main

                # Habilitar WinRM
                New-NetFirewallRule -DisplayName "Allow WinRM HTTP" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow
                New-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -Direction Inbound -LocalPort 5986 -Protocol TCP -Action Allow
                winrm quickconfig -quiet
                winrm set winrm/config/service/auth @{Basic="true"}
                winrm set winrm/config/service @{AllowUnencrypted="true"}
                winrm set winrm/config/winrs @{MaxMemoryPerShellMB="1024"}
                winrm set winrm/config @{MaxTimeoutms="1800000"}
                Set-ExecutionPolicy Unrestricted -Force
                Restart-Service WinRM
                </powershell>
                EOF
}
