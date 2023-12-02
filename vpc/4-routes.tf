
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
    }

  tags = {
    "Name" = "public"
  }
}


resource "aws_route_table_association" "public-us-east-1a" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public-us-east-1a.id
}




