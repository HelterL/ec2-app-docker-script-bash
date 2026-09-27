module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 5.0"
  name                        = var.name
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = var.associate_public_ip_address

  user_data = var.user_data

  tags = var.tags
}
