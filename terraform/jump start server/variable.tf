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
    Name = "jump-start-server"
  }
}

variable "security_group_id" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "instance_profile" {
  type = string
  default = "my-ec2-instance-profile"
}

variable "user_data" {
  description = "install apache server on ec2."
  type        = string
  default     = <<-EOF
                #!/bin/bash


                # Make user-data re-run on every restart
                sudo cloud-init clean
                echo "true" > /var/lib/cloud/instance/sem/config_scripts_user

                set -xe
                sudo yum update -y
                sudo yum install -y java-17-amazon-corretto-headless awscli
                sudo dnf install -y postgresql17
                sudo mkdir app
                sudo aws s3 cp s3://java-app-jar-files-bucket/jars/demo-0.0.1-SNAPSHOT.jar /home/ec2-user/app/java-app.jar
                sudo chown ec2-user:ec2-user /home/ec2-user/app/java-app.jar
                sudo chmod u+x /home/ec2-user/app/java-app.jar
                
                sudo tee /etc/java-app.env > /dev/null <<'EOL'
                DB_HOST=java-app-postgres.c0l8oguqa1lb.us-east-1.rds.amazonaws.com
                DB_PORT=5432
                DB_NAME=postgres
                DB_USERNAME=postgres
                DB_PASSWORD=java-postgres
                EOL

                sudo tee /etc/systemd/system/java-app.service > /dev/null <<EOL
                [Unit]
                Description=Spring Boot Application
                After=network.target

                [Service]
                User=ec2-user
                EnvironmentFile=/etc/java-app.env
                ExecStart=/usr/bin/java -jar /home/ec2-user/app/java-app.jar
                Restart=always
                RestartSec=5
                StandardOutput=file:/home/ec2-user/app/app.log
                StandardError=file:/home/ec2-user/app/app-error.log

                [Install]
                WantedBy=multi-user.target
                EOL
                
                sudo systemctl daemon-reload
                sudo systemctl enable java-app
                sudo systemctl start java-app
      
  EOF
}
