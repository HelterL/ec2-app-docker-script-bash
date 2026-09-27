variable "name" {
  description = "Nome do security group"
  type        = string
}

variable "description" {
  description = "Descricao do security group"
  type        = string
  default     = "Security group for the web application"
}

variable "vpc_id" {
  description = "ID da VPC onde o security group sera criado"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "CIDRs autorizados nas regras de entrada"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ingress_rules" {
  description = "Regras de entrada predefinidas do modulo (HTTP, HTTPS e SSH)"
  type        = list(string)
  default     = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]
}

variable "egress_rules" {
  description = "Regras de saida predefinidas do modulo"
  type        = list(string)
  default     = ["all-all"]
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos criados pelo modulo"
  type        = map(string)
  default     = {}
}
