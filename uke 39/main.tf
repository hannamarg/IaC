locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
  
}

provider "azurerm" {
  subscription_id = "a3adf20e-4966-4afb-b717-4de1baae6db1"
  features {

  }
}

resource "azurerm_resource_group" "hmhd-rg" {
  name     = "rg-hmhd-${local.workspaces_suffix}"
  location = var.location
}

resource "azurerm_storage_account" "sa-demo" {
  name                     = "hmhddemo321"
  resource_group_name      = azurerm_resource_group.hmhd-rg.name
  location                 = azurerm_resource_group.hmhd-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group-hmhd"
  location            = azurerm_resource_group.hmhd-rg.location
  resource_group_name = azurerm_resource_group.hmhd-rg.name
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet
  location            = azurerm_resource_group.hmhd-rg.location
  resource_group_name = azurerm_resource_group.hmhd-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = var.subnet1
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = var.subnet2
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}
