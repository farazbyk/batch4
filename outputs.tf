output "private_subnet_id" {
  value = aws_subnet.private.*.id
}

output "public_subnet_id" {
  value = aws_subnet.public.*.id
}

output "public_cidr_block" {
  value = aws_subnet.public.*.cidr_block
}

output "private_cidr_block" {
  value = aws_subnet.private.*.cidr_block
}

output "vpc_id" { 
  value = aws_vpc.vpc.id
} 
output "lb_arn" {
  value = aws_elb.web_elb.arn
}