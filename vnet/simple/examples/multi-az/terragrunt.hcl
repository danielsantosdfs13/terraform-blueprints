# ----------------------------------------------------------------------------------------------------------------------
# Cria um FSx do tipo Multi-AZ utilizando o Self-Managed Microsoft Active Directory
#
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  source = "git::ssh://git@gitlabssh.sharedservices.local/devops/terraform-blueprints.git//fsx/simple?ref=1.0.296"
}

# Include all settings from the root terraform.hcl file
include {
  path = find_in_parent_folders()
}

#------------------------------------------------------------------------------------------------------------------------
# Dependências
#------------------------------------------------------------------------------------------------------------------------
# Descomente esse código se quiser usar a dependência de um dos recursos já criados via iac
#
# dependency "security_group" {
#   # Path do componente de security group
#   config_path = "../path-relativo-para-o-componente-security-group"
#   mock_outputs = {
#     # Id qualquer, apenas para não quebrar o plan
#     id = "temporary-id"
#   }
#   # Sempre declarar essa linha para permitir
#   # o mock apenas nestes comandos
#   mock_outputs_allowed_terraform_commands = ["validate", "plan"]
# }

inputs = {
  
  # Endereço DNS utilizado no AD
  dns_ips = ["10.0.0.50"]
  
  # Define o volume em GB do Storage utilizado. O mínimo é de 32GB e o máximo de 2000GB
  storage_capacity = 32

  # Define o a velocidade de throughput em Mbps do FSx. O mínimo é 8 e o máximo é 2048
  throughput_capacity = 16
  
  # Subnets que serão utilizadas no FSx
  subnet_ids = ["subnet-0b082999a21ce3a74" , "subnet-016cec2593b0667ab"]
  
  # Security Group que será utilizado no FSx. Para mais detalhes sobre a liberação de portas necessárias do SG consultar a documentação: https://docs.aws.amazon.com/fsx/latest/WindowsGuide/limit-access-security-groups.html
  # Caso queira usar a dependência do recurso security group, utilize o exemplo abaixo:
  # Ex.: security_group_ids = [dependency.security_group.outputs.id]
  sg_id = ["sg-0d7015b3f4fa759d4"]

  # Subnet especifica que o FSx irá alocar
  preferred_subnet_id = "subnet-016cec2593b0667ab"

  # OU do AD que será utilizada no FSx
  ou_name = "OU=WINDOWS,OU=HML,OU=SAE1,OU=SERVIDORES,OU=AWS,OU=BANCO_INTERMEDIUM,DC=intermedium,DC=local"

  # Define se o FSx será Multi-AZ ou Singel-AZ
  deployment_type = "MULTI_AZ_1"
  
  # Nome utilizado pelo AD escolhido
  # Valor default = intermedium.local
  # domain_name = "intermedium.local"
  
  # O tipo de storage que será utilizado, os tipos suportados são: SSD e HDD. O valor default está como SSD
  # Valor default = SSD
  # storage_type = "SSD"

  # Define a retenção de Backup do FSx e se irá ter ou não backup, nesse caso está como valor default zero, ou seja, o backup está desabilitado. Aceita o máximo de 90 dias.
  # Valor default = 0
  # backup_retention = 0


  # ---------------------------------------------------------------------------------------------------------------------
  # PARAMÊTROS DO MÓDULO DE TAGS DO BANCO INTER
  # Vide: https://confluence.bancointer.com.br/pages/viewpage.action?pageId=8032622
  # ---------------------------------------------------------------------------------------------------------------------

  # Classificação da informação do recurso criado = INTERNA, RESTRITA ou PUBLICA
  information_classification = "INTERNA"

  # Grau de severidade e relevância do objeto. Valores aceitos são: CRITICO, MEDIO, BAIXO
  severity = "MEDIO"
}
