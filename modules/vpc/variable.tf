variable "cidr_block" {
  description = "Cidr block for the vpc"
  type = string
}

variable "environment_name" {
  description = "Environment for which the app is deployed"
  type = string
}

variable "private_subnet" {
  description = "Cidr block for public subnet"
  type = string
}

variable "public_subnet" {
  description = "Cidr block for public subnet"
  type = string
}
