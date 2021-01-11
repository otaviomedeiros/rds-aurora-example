variable "profile" {
  type        = string
  description = "Profile to access aws account"
}

variable "region" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "main_vpc_cidr_block" {
  type = string
}

variable "ssh_key_pair_name" {
  type = string
}
