resource "aws_subnet" "public-us-east-1a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-us-east-1a"
  }
}


