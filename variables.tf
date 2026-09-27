variable "aws_region" {
  description = "Regiao da AWS onde os recursos serao criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefixo usado para nomear e taguear todos os recursos"
  type        = string
  default     = "project-devops"
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidade das subnets publicas"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "public_subnets" {
  description = "Blocos CIDR das subnets publicas (um por zona de disponibilidade)"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "allowed_ingress_cidr_blocks" {
  description = "CIDRs com permissao de acesso HTTP, HTTPS e SSH na instancia"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "ID da AMI (Ubuntu, pois o script.sh usa apt) usada pela instancia"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
  description = "Tipo da instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nome do key pair usado para acessar a instancia via SSH"
  type        = string
  default     = "aws-server"
}
