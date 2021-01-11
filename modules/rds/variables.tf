variable "instances_count" {
  type = number
}

variable "availability_zones" {
  type = list
}

variable "db_security_group_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list
}


