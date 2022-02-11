provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "default"
}

terraform {
    backend "s3" {
        bucket = "terraform-state-file-batch4"
        key = "ec2-1/terraform.state"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "batch4"
    }
}


resource "aws_instance" "example1" {

  ami           = "ami-04ad2567c9e3d7893"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-08fea0f6be8bd1180"]
  subnet_id   = data.terraform_remote_state.vpc.outputs.private_subnet_id[1]
  key_name = "deployer-key"
  tags = { "Name" = "ec2-terraform-faraz" }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "terraform-state-file-batch4"
    key     = "vpc/terraform.state"
    region  = "us-east-1"
    profile = "default"
  }
 }