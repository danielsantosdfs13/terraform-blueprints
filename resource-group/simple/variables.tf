provider "azurerm" {
  features {}
}
variable "resource_group_name" {
  type        = string
  description = "Nome do resource group a ser criado"
}

variable "resource_group_location" {
  description = "Localização do resource group. Para pegar a lista de todas as localizações, execute 'az account list-locations -o table'"
  type        = string
  default     = "eastus2"
}

variable "tags" {
  description = "Tags a serem atribuídas ao resource group"
  type        = map(string)
  default     = {}
}
