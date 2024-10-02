variable "location" {
  type = string
  description = "deployment location"
  default = "West Europe"
}

variable "vnet" {
  type = string
  description = "vnet name"
  default = "example-network-hmhd"
}

variable "subnet1" {
  type = string
  description = "subnet nr 1 name"
  default = "subnet1-hmhd"
}

variable "subnet2" {
  type = string
  description = "subnet nr 2 name"
  default = "subnet2-hmhd"
}