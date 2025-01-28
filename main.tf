# AWS Provider Configuration
provider "aws" {
  region = "ap-south-1"
}

# Data source to fetch the latest Ubuntu AMI
data "aws_ami" "ubuntu_latest" {
  most_recent = true

  # Filter AMIs by owner and name pattern
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID (Ubuntu AMIs)
}

# Use the fetched AMI in an EC2 instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t2.micro"

  tags = {
    Name = "Ubuntu-Latest-AMI"
  }
}
