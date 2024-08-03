output "linux_dns" {
    value = {for index, data in aws_instance.web_server : index => data.public_dns}
}
output "windows_dns" {
    value = aws_instance.database_server.public_dns
}

output "linux_ami_os" {
  value = data.aws_ami.linux_ami_os.name
}

output "windows_ami_os" {
  value = data.aws_ami.windows_ami_os.name
}
