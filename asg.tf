

resource "aws_launch_configuration" "web" {
  name_prefix = "web-"

  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "batch4"
  associate_public_ip_address = false
  iam_instance_profile  = aws_iam_instance_profile.s3_profile.name
 
  security_groups = [ aws_security_group.allow_tls.id ]
 user_data = "${file("init-script.sh")}"
 lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 3
  
  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.web_elb.id
  ]

  launch_configuration = aws_launch_configuration.web.name


  vpc_zone_identifier  = aws_subnet.private.*.id

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }

}
