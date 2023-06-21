resource "aws_eip" "ip" {
  domain = "vpc"
  instance = aws_instance.web_server.id
}