output "linux_ip" {
    value = {for index, data in aws_instance.web_server : index => data.public_ip}
}
output "windows_ip" {
    value = aws_instance.database_server.public_ip
}

output "linux_ami_os" {
  value = data.aws_ami.linux_ami_os.name
}

output "windows_ami_os" {
  value = data.aws_ami.windows_ami_os.name
}

output "windows_instance_id" {
  value = aws_instance.database_server.id
}

output "linux_instance_id" {
    value = {for index, data in aws_instance.web_server : index => data.id}
}
