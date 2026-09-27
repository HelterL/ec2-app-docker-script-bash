output "id" {
  description = "ID da instancia EC2"
  value       = module.ec2.id
}

output "public_ip" {
  description = "IP publico da instancia"
  value       = module.ec2.public_ip
}

output "public_dns" {
  description = "DNS publico da instancia"
  value       = module.ec2.public_dns
}

output "private_ip" {
  description = "IP privado da instancia"
  value       = module.ec2.private_ip
}

output "application_url" {
  description = "URL da aplicacao publicada na porta 80"
  value       = "http://${module.ec2.public_ip}"
}
