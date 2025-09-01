
variable "instance_name" {
  description = "Tag name for the instance"
  type        = string
  default     = "jump-start-server"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-00ca32bbc84273381" # Amazon Linux 2 AMI (update based on region)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "terraform-ssh"
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default = {
    Name = "amazon-linux-ec2"
  }
}

variable "user-data" {
  description = "install apache server on ec2."
  type        = string
  default     = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Hello from Terraform EC2" > /var/www/html/index.html
                EOF
}
