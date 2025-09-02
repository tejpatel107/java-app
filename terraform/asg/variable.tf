variable "name" {
  description = "Base name for resources (will be used as prefix)."
  type        = string
  default     = "java-app-asg"
}

variable "target_group_arns" {
  type = set(string)

}

variable "subnet_ids" {
  description = "List of subnet IDs where the ASG can launch instances."
  type        = list(string)
}

variable "desired_capacity" {
  type    = string
  default = 2
}
