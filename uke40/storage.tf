resource "azurerm_storage_account" "sa-demo" {
  name                     = "hmhddemonyttnavn2"
  resource_group_name      = azurerm_resource_group.hmhd-rg.name
  location                 = azurerm_resource_group.hmhd-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}