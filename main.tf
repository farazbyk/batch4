provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "default"
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUntO0DMa5tkSQywtn6zsB8kMVbJDl26h6m/MlB/goM7WClXf4FZ9dejZioKS6j01bl7oD/K7pf9IzECtUHn/Y7yc52xQf8zHeueU67gCgH/LuZkTD5WzKd/VOpijLE1u1LxBPDk8dnZd3JT6osHTvfOi6rYv6vY3hh+Vw1uAetuIycBKKDeqmnPoL2J0Lh2x7gpm90OT4PPS2nWwhhslExCPXob/X4SGCRKGa2aXfPnTwqTSPYlC4Enm8IZ2gPeV+rnI1WcneYWAixTG4+D+yO//BaxNM2+n7BSkeCu3OGQObLXf1IQwPDBYdy5zhuHx/zghSoWfXhqy84Ge5toip"
  #public_key = "ssh-rsa AFucbN1jjItcVov1ETCchbFQzeWoOm8BiVPYNDAvAJgnzLRzZys5rHrr46ISn2CaxJuT4S2uixHYv+wfhOGagpnBDzIhWGG8zI9b5krNj+QyYQ9j37O314YgRFQdOPNs0sUKV2kkSjuSpOCbiNYnEDxtgNKjg3/UelPwTF1XrtQavgW0vkd4zfggJpzT/beaiqHNUdIjKQUcLn8QSek9YCEwmF5h9Hkn6q/sLOT"
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids = var.sg_ids
  subnet_id   = "subnet-98008bb7"
  key_name = aws_key_pair.deployer.key_name
  tags = {
      "Name" = "ec2-terraform-faraz"  }
  }
