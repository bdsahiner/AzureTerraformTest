variable "resource_group_name" {
  type    = string
  default = "berkanRGtesting"
}

variable "location_name" {
  type    = string
  default = "West Europe"
}

variable "virtual_network_name" {
  type    = string
  default = "berkanVNtesting"
}

variable "subnet_name" {
  type    = string
  default = "berkanSNtesting"
}

variable "network_security_group_name" {
  type    = string
  default = "berkanNSGtesting"
}

variable "network_interface_name" {
  type    = string
  default = "berkanNItesting"
}

variable "public_ip_address_name" {
  type    = string
  default = "berkanPItesting"
}

variable "AdressBlock" {
  type    = list(string)
  default = ["10.123.0.0/16"]
}

variable "address_prefixes" {
  type    = list(string)
  default = ["10.123.1.0/24"]
}

variable "container_app_environment_name" {
  type    = string
  default = "berkanCAEtesting"
}

variable "log_analytics_workspace_name" {
  type    = string
  default = "berkanLAWtesting"
}