##terraform {
##  required_providers {
##    aws = {
##      source  = "hashicorp/aws"
##      version = "~> 5.4.0"
##    }
##  }
##}
##
### Configure the AWS Provider
##provider "aws" {
##  region = var.region
##  access_key = var.AWS_ACCESS_KEY_ID
##  secret_key = var.AWS_SECRET_KEY
##}
##
##resource "aws_key_pair" "DevOps" {
##  key_name   = "DevOps"
##  public_key = file("~/.ssh/id_rsa.pub")
##}
## Use default VPC
#data "aws_vpc" "default" {
#  default = true
#}
#data "aws_caller_identity" "current" {
#}
#
#resource "aws_instance" "web_server" {
#  key_name      = aws_key_pair.DevOps.key_name
#  ami = "ami-04e4606740c9c9381"
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [aws_security_group.sg.id]
#  tags = {
#    name = "Web Server Nginx"
#    owner = "DevOps"
#  }
#}
#
## Create SG
#resource "aws_security_group" "sg" {
#  name = "security_group"
#  description = "Allow HTTP, HTTPS and SSH traffic via Terraform"
#  tags = {
#    name = "For DevOps Task"
#    owner = "DevOps"
#  }
#
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = var.my_ip
#  }
#
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = var.my_ip
#  }
#
#  ingress {
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = var.my_ip
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#data "template_file" "policy" {
#  template = file("${path.module}/policy_add_ip.json")
#  vars = {
#    region      = var.region
#    account_id  = data.aws_caller_identity.current.account_id
#    sg_id       = aws_security_group.sg.id
#  }
#}
#
#resource "aws_iam_policy" "add_ip" {
#  name        = "Add_IP_address"
#  description = "Add IP address IAM policy"
#  policy      = data.template_file.policy.rendered
#}
#
#resource "aws_iam_user" "New_user" {
#  name = var.username_iam
#}
#
#resource "aws_iam_user_policy_attachment" "AttachCustomPolicy" {
#  policy_arn = aws_iam_policy.add_ip.arn
#  user       = aws_iam_user.Check_task.name
#}
#
#resource "aws_iam_user_policy_attachment" "AttachEC2ReadOnlyPolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
#  user       = aws_iam_user.Check_task.name
#}
#
#resource "aws_eip" "ip" {
#  domain = "vpc"
#  instance = aws_instance.web_server.id
#}
#
#data "template_file" "inventory" {
#  template = file("./_template/inventory.tpl")
#
#  vars = {
#    user = var.user
#    host = join("", ["ansible_host=", aws_eip.ip.public_ip])
#    public_dns = aws_instance.web_server.public_dns
#    api_key = var.api_key
#  }
#}
#
#resource "local_file" "save_inventory" {
#  content  = data.template_file.inventory.rendered
#  filename = "./inventory"
#}