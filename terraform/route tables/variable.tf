variable "vpc_id" {
  type        = string
  description = "VPC ID to associate the route table with"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with this route table"
}

variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway ID (needed only for public route tables)"
  default     = null
}

variable "create_internet_gateway_route" {
  type        = bool
  description = "Whether to create a route to IGW (true for public, false for private)"
  default     = false
}

variable "name" {
  type        = string
  description = "Name tag for the route table"
}
