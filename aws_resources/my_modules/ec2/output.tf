output "linux_ip" {
    value = {for index, data in aws_instance.web_server : index => data.public_ip}
}

output "linux_private_ip" {
    value = {for index, data in aws_instance.web_server : index => data.private_ip}
}

# output "linux_instance_id" {
#     value = {for index, data in aws_instance.web_server : index => data.id}
# }

output "windows_ip" {
    value = aws_instance.database_server.public_ip
}

output "windows_private_ip" {
    value = aws_instance.database_server.private_ip
}

output "windows_instance_id" {
  value = aws_instance.database_server.id
}