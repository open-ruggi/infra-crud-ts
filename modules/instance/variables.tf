variable "environment" {
  description = "The Deployment environment"
}

variable "public_subnets" {
   type = string
}

variable "private_subnets" {
  type = string
}

variable key_name {
  type = string
}

variable vpc_id {
  type = string
}

