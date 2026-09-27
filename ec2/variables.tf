variable "name" {
  description = "Nome da instancia EC2"
  type        = string
}

variable "ami" {
  description = "ID da AMI usada pela instancia (Ubuntu, pois o script.sh usa apt)"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instancia"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nome do key pair usado para acesso via SSH"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a instancia sera criada"
  type        = string
}

variable "security_group_id" {
  description = "ID do security group associado a instancia"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Se true, associa um IP publico a instancia"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "Script executado no boot da instancia"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos criados pelo modulo"
  type        = map(string)
  default     = {}
}
