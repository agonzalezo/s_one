resource "aws_key_pair" "ssh_key" {
  key_name = "${var.environment}_ssh_key"
  public_key = file(var.ssh_pub_path)
  tags = {
    Name = "${var.environment}_ssh_key"
  }
}