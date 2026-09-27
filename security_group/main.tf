module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules

  tags = var.tags
}
