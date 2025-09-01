variable "name" {
  type        = string
  description = "Name of the ALB"
  default = "java-app-load-balancer"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets for the ALB"
}

variable "security_groups" {
  type        = list(string)
  description = "Security groups for the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "listener_port" {
  type        = number
  default     = 80
  description = "Port for the listener"
}

variable "target_port" {
  type        = number
  default     = 8080
  description = "Port for the target group (EC2/ASG apps)"
}

# variable "health_check_path" {
#   type        = string
#   default     = "/"
#   description = "Path for health check"
# }
