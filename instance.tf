resource "aws_instance" "example1" {

  ami           = "ami-04ad2567c9e3d7893"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-08fea0f6be8bd1180"]
  subnet_id   = "subnet-98008bb7"
  key_name = "deployer-key"
  tags = { "Name" = "ec2-terraform-faraz" }
}
