resource "aws_autoscaling_group" "asg" {
  name = var.name
  desired_capacity = 2
  min_size = 2
  max_size = 3

  vpc_zone_identifier = var.subnet_ids
  target_group_arns = var.target_group_arns
  health_check_type = "EC2"

  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
    
  }
}

resource "aws_launch_template" "launch_template" {
  name = "java-app-launch-template"
  image_id = var.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name = "terraform-ssh"
}