terraform {
  source = "github.com/danielsantosdfs13/terraform-blueprints/vnet/simple"
}

# Include all settings from the root terraform.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  create_resource_group         = true
  resource_group_name           = "rg-demo-westeurope-01"
  vnetwork_name                 = "vnet-demo-westeurope-001"
  location                      = "westeurope"
  vnet_address_space            = ["10.1.0.0/16"]
  gateway_subnet_address_prefix = ["10.1.1.0/27"]

  # Adding Standard DDoS Plan, and custom DNS servers (Optional)
  create_ddos_plan = false

  subnets = {
    mgnt_subnet = {
      subnet_name           = "management"
      subnet_address_prefix = ["10.1.2.0/24"]
      service_endpoints     = ["Microsoft.Storage"]
    }

    dmz_subnet = {
      subnet_name           = "appgateway"
      subnet_address_prefix = ["10.1.3.0/24"]
      service_endpoints     = ["Microsoft.Storage"]
    }
  }

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
