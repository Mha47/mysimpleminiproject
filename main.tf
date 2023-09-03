resource "aws_s3_bucket" "bucket" {
  bucket = "sharir-tf-test-bucket"

  tags = {
    Name        = "Sharir Bucket"
    Environment = "Dev"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "sctp-ce3-tfstate-bucket"
        key    = "sharir47.tfstate"
        region = "us-east-1"
    }
}

resource "aws_instance" "sharir_web_server-1" {
  ami           = "ami-0f34c5ae932e6f0e4" 
  instance_type = "t2.micro"
  key_name      = "SharirKeyPair" 
  vpc_security_group_ids = ["sg-00509529fa83dfd65"] 
  associate_public_ip_address = true

  tags = {
    Name = "Sharirwebserver-1"
  }
}

resource "aws_instance" "sharir_web_server-2" {
  ami           = "ami-0f34c5ae932e6f0e4" 
  instance_type = "t2.micro"
  key_name      = "SharirKeyPair" 
  vpc_security_group_ids = ["sg-00509529fa83dfd65"] 
  associate_public_ip_address = true

  tags = {
    Name = "Sharirwebserver-2"
  }
}

resource "aws_instance" "sharir_Ansible_server" {
  ami           = "ami-0f34c5ae932e6f0e4" 
  instance_type = "t2.micro"
  key_name      = "SharirKeyPair" 
  user_data     = <<-EOF
                    #!/bin/bash
                    sudo yum update -y
                    sudo yum install pip -y
                    sudo python3 -m pip install --user ansible
                  EOF
  vpc_security_group_ids = ["sg-00509529fa83dfd65"] 
  associate_public_ip_address = true

  tags = {
    Name = "SharirAnsibleserver"
  }
}