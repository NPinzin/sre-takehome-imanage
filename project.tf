terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = AWS_ACCESS_KEY_ID #Figure out how to use w/ github actions, added as repo secret already
  secret_key = AWS_SECRET_ACCESS_KEY
}

resource "aws_security_group" "ingress_traffic" {
  ingress {
    description = "Allows inbound TCP traffic on port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  name = "ingress_sec_group"
}

resource "aws_instance" "ec2example" {
  ami = "ami-091d7d61336a4c68f"
  instance_type = "t3.micro"
  security_groups = [aws_security_group.ingress_traffic.name]



  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras enable nginx1
  yum install -y nginx
  systemctl enable nginx
  systemctl start nginx
  EOF
}

output "public_ip" {
  description = "Show the public IP of the server"
  value = aws_instance.ec2example.public_ip
}