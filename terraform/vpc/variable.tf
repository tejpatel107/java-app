variable "cidr_block" {
  description = "CIDR blocks allowed for ingress"
  type        = string
  # default     = "10.0.0.0/16"
}

variable "name" {
  description = "name for vpc"
  type        = string
  default     = "java-app-vpc"
}

variable "ig_name" {
  description = "name for internet gateway"
  type        = string
  default     = "java-app-vpc"
}