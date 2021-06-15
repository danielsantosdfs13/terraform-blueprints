terraform {
  backend "azurerm" {}
}

module "resource-group" {
  source                         = "github.com/danielsantosdfs13/terraform-modules/resource-group"
  
  resource_group_name            = var.resource_group_name
  resource_group_location        = var.resource_group_location

  # Adding TAG's to your Azure resources (Required)
  tags = var.tags
}
