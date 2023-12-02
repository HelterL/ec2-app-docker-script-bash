output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1a" {
  value = aws_subnet.public-us-east-1a.id
}
