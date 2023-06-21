resource "aws_key_pair" "DevOps" {
  key_name   = "DevOps"
  public_key = file("~/.ssh/id_rsa.pub")
}