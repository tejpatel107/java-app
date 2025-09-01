resource "aws_instance" "new-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  tags                   = var.tags
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.new-sg.id]
  user_data              = var.user-data
  iam_instance_profile   = aws_iam_instance_profile.ec2-profile.name
}