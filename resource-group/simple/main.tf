terraform {
  backend "azurerm" {}
}

module "resource-group" {
  source                         = "github.com/danielsantosdfs13/terraform-modules/resource-group"
  
  resource_group_name            = "teste-rg"
  resource_group_location        = "eastus2"

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
