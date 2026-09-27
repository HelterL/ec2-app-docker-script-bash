output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "IDs das subnets publicas criadas"
  value       = module.vpc.public_subnets
}
