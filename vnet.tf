resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name  // Use a variable to define the name
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks-rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "system_subnet" {
  name                 = "system-subnet"
  resource_group_name  = azurerm_resource_group.aks-rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}
