terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }

}

provider "azurerm" {
  features {}
}


data "azurerm_resources" "terraform_learning" {
  resource_group_name = "tf-lab"
  location = "northeurope"
}



resource "azurerm_data_factory" "TerraformDataFactory" {
  name                = "TerraformDataFactory_tf-lab"
  location            = azurerm_resource_group.terraform_learning.location
  resource_group_name = azurerm_resource_group.terraform_learning.name
}


resource "azurerm_storage_account" "tfstorageaccount911" {
  name                     = "tfstorageaccount911_tf-lab"
  location                 = azurerm_resource_group.terraform_learning.location
  resource_group_name      = azurerm_resource_group.terraform_learning.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.tfstorageaccount911.name
  container_access_type = "private"
}

resource "azurerm_databricks_workspace" "terraf-databricks" {
  name                = "terraf-databricks_tf-lab"
  location            = azurerm_resource_group.terraform_learning.location
  resource_group_name = azurerm_resource_group.terraform_learning.name
  sku                 = "standard"
}




resource "azurerm_mssql_server" "tfmssqlserverps" {
  name                         = "tfmssqlserverps_tf-lab "
  location                     = azurerm_resource_group.terraform_learning.location
  resource_group_name          = azurerm_resource_group.terraform_learning.name
  version                      = "12.0"
  administrator_login          = "parulsrivastavaaaa"
  administrator_login_password = "4-v3ry-53cr37-D0notcopyit"

  tags = {
    environment = "dev"
  }
}


resource "azurerm_sql_database" "tfsqldatabase" {
  name                = "tfsqldatabasetf-lab"
  location            = azurerm_resource_group.terraform_learning.location
  resource_group_name = azurerm_resource_group.terraform_learning.name
  server_name         = azurerm_mssql_server.tfmssqlserverps.name

  tags = {
    environment = "dev"
  }
}


