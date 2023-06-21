resource "aws_instance" "web_server" {
  key_name               = aws_key_pair.DevOps.key_name
  ami                    = "ami-04e4606740c9c9381"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    name  = "Web Server Nginx"
    owner = "DevOps"
  }
}