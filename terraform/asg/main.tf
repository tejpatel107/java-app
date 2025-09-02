resource "aws_autoscaling_group" "asg" {
  name = var.name
  desired_capacity = 2
  min_size = 2
  max_size = 3

  vpc_zone_identifier = var.subnet_ids
  target_group_arns = var.target_group_arns
  health_check_type = "EC2"

  launch_template {
    id = "lt-02557d246e0e9a5ec"
    version = "$Latest"
    
  }
}