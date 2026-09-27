variable "name" {
  description = "Nome da VPC e prefixo dos nomes dos recursos de rede"
  type        = string
}

variable "cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Zonas de disponibilidade onde as subnets publicas serao criadas"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "public_subnets" {
  description = "Blocos CIDR das subnets publicas (um por zona de disponibilidade)"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos criados pelo modulo"
  type        = map(string)
  default     = {}
}
