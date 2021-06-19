terraform {
  source = "github.com/danielsantosdfs13/terraform-blueprints/resource-group/simple"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  resource_group_name            = "simple"
  resource_group_location        = "eastus2"

  tags = {
    ProjectName  = "network"
    Env          = "sample"
    Owner        = "admin@ddsit.com"
    Solution     = "NETWK"
    Severity     = "Critical"
  }
}