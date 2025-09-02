resource "aws_instance" "jump_start_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  tags                   = var.tags
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_id
  user_data              = var.user_data
  iam_instance_profile   = var.instance_profile
  subnet_id              = var.subnet_id
}