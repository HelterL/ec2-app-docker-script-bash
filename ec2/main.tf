resource "aws_instance" "web" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "aws-server"
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.sec_group_id ]
  associate_public_ip_address = true
  user_data = file("script.sh")
  tags = {
    Name = "HelloWorld"
  }
}