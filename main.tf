# #In Azure, all infrastructure elements such as virtual machines, storage, and our Kubernetes cluster need to be attached to a resource group.

# resource "azurerm_resource_group" "aks-rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

# resource "azurerm_role_assignment" "role_acrpull" {
#   scope                            = azurerm_container_registry.acr.id
#   role_definition_name             = "AcrPull"
#   principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
#   skip_service_principal_aad_check = true
# }



# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = var.cluster_name
#   kubernetes_version  = var.kubernetes_version
#   location            = var.location
#   resource_group_name = azurerm_resource_group.aks-rg.name
#   dns_prefix          = var.cluster_name

#   default_node_pool {
#     name                = "system"
#     node_count          = var.system_node_count
#     vm_size             = "Standard_DS2_v2"
#     type                = "VirtualMachineScaleSets"
#     zones  = ["1"]
#     enable_auto_scaling = false
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   network_profile {
#     load_balancer_sku = "standard"
#     network_plugin    = "kubenet" 
#   }
# }

# resource "azurerm_virtual_network" "aks_vnet" {
#   name                = "myVnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.aks-rg.name
# }

# resource "azurerm_subnet" "aks_subnet" {
#   name                 = "mySubnet"
#   resource_group_name  = azurerm_resource_group.aks-rg.name
#   virtual_network_name = azurerm_virtual_network.aks_vnet.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    zones               = ["1"]
    enable_auto_scaling = false
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
  }

#   resource "azurerm_container_registry" "acr" {
#   name                = var.acr_name
#   resource_group_name = azurerm_resource_group.aks-rg.name
#   location            = var.location
#   sku                 = "Standard"
#   admin_enabled       = true
# }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure" // Change to 'azure' to use Azure CNI
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

