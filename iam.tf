data "aws_caller_identity" "current" {
}

data "template_file" "policy" {
  template = file("${path.module}/policy_add_ip.json")
  vars = {
    region     = var.region
    account_id = data.aws_caller_identity.current.account_id
    sg_id      = aws_security_group.sg.id
  }
}

resource "aws_iam_policy" "add_ip" {
  name        = "Add_IP_address"
  description = "Add IP address IAM policy"
  policy      = data.template_file.policy.rendered
}

resource "aws_iam_user" "Check_task" {
  name = "Check_task"
}

resource "aws_iam_user_policy_attachment" "AttachCustomPolicy" {
  policy_arn = aws_iam_policy.add_ip.arn
  user       = aws_iam_user.Check_task.name
}

resource "aws_iam_user_policy_attachment" "AttachEC2ReadOnlyPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  user       = aws_iam_user.Check_task.name
}