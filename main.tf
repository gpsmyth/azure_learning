# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "rg" {
  name     = "rg-network-storage"
  location = "australiaeast"
}

# -----------------------------
# Virtual Network + Subnet
# -----------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-main"
  address_space       = ["10.10.0.0/20"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-app"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Not mirroring production.

  https_traffic_only_enabled = true # Default is true as noted in README.md, but explicitly set here for clarity

  tags = {
    environment = "test"
  }
}

resource "azurerm_role_assignment" "rg_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}
// Storage Blob Data Contributor is better for apps to read/write blobs