provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "default"
}


terraform {
  backend "s3" {
    bucket         = "terraform-29"
    key            = "faraz/module/ec2/terraform-state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "faraz-lock"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIBx1FXxaa/GN+jf597bj3mQrhril+IyyNEOmYD7mDDATJ33s7UUt/QHz+LTHGsdhXD0Td6hBy6BYeuqL66MBTFY5ccmtNiy8Ot0ErPbEKHv0HBAFucbN1jjItcVov1ETCchbFQzeWoOm8BiVPYNDAvAJgnzLRzZys5rHrr46ISn2CaxJuT4S2uixHYv+wfhOGagpnBDzIhWGG8zI9b5krNj+QyYQ9j37O314YgRFQdOPNs0sUKV2kkSjuSpOCbiNYnEDxtgNKjg3/UelPwTF1XrtQavgW0vkd4zfggJpzT/beaiqHNUdIjKQUcLn8QSek9YCEwmF5h9Hkn6q/sLOT"
}

module "ec2" {
    source = "../tf-instance"

  my_amis = {
   "awslinux"   = "ami-01cc34ab2709337aa"
   "ubuntu"   = "ami-083654bd07b5da81d"

 }
 instance_type = "t2.micro"
 sg = ["sg-0eafd5799c9c65ca4"]
 subnet_id_module = "subnet-0d2f7a8d315d05115"
 key-name = aws_key_pair.deployer.key_name
 custom_tags = {
   "linux-ID"   = "ami-01cc34ab2709337aa"
   "ubuntu-ID"   = "ami-083654bd07b5da81d"

 }
}
