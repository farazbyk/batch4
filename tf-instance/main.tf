resource "aws_instance" "example1" {

  for_each          = var.my_amis
  ami          = each.value
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg
  subnet_id   = var.subnet_id_module
  key_name = var.key-name
  tags = var.custom_tags
}
