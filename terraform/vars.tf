variable "region" {
  description = "Region de la instancia"
  type        = string
  default     = "us-east-1"
}

variable "access_key" {
  description = "Access Key de la cuenta AWS"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Secret Key de la cuenta AWS"
  type        = string
  default     = "" 
}

variable "ami" {
  description = "AMI de la instancia: informa a AWS que instancia queremos levantar"
  type        = string
  default     = "ami-052efd3df9dad4825"//Last release Ubuntu, suele cambiar con el tiempo
}

variable "key_pair" {
  description = "Nombre par de claves para conexión segura a la instancia"
  type        = string
  default     = "clavestfg"
}