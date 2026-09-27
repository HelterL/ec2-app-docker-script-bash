output "instance_id" {
  description = "ID da instancia EC2"
  value       = module.ec2.id
}

output "instance_public_ip" {
  description = "IP publico da instancia EC2"
  value       = module.ec2.public_ip
}

output "instance_public_dns" {
  description = "DNS publico da instancia EC2"
  value       = module.ec2.public_dns
}

output "application_url" {
  description = "URL da aplicacao publicada na porta 80"
  value       = "http://${module.ec2.public_ip}"
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "security_group_id" {
  description = "ID do security group criado"
  value       = module.security_group.security_group_id
}
