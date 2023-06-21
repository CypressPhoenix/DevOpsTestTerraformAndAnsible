data "template_file" "inventory" {
  template = file("./_template/inventory.tpl")

  vars = {
    user       = var.user
    host       = join("", ["ansible_host=", aws_eip.ip.public_ip])
    public_dns = aws_instance.web_server.public_dns
    api_key    = var.api_key
  }
}

resource "local_file" "save_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "./inventory"
}