output "baked_ami_id" {
  value = aws_ami_from_instance.baked_ami.id
}