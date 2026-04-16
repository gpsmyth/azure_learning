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
