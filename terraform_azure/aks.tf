resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.azure_region_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  azure_policy_enabled = false

  http_application_routing_enabled = false

/*
  ingress_application_gateway {
    gateway_name = application_gateway
    subnet_cidr = "10.1.1.0/24"
  }
*/
/*
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.0.0.0/16"
    dns_service_ip    = "10.0.0.10"
//    docker_bridge_cidr = "172.17.0.1/16"
  }
*/
//  role_based_access_control {
//    enabled = true
//  }

  tags = {
    Name = var.cluster_name
  }

  depends_on = [
    azurerm_virtual_network.main,
    azurerm_subnet.public_subnet,
    azurerm_subnet.private_subnet
  ]
}
/*
resource "azurerm_virtual_network" "aks" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tags = {
    Name = "aks"
  }
}
*/

/*
resource "azurerm_subnet" "public" {
  count                = length(var.subnet_names)
  name                 = "public-${element(var.subnet_names, count.index)}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [element(var.public_subnet_cidrs, count.index)]
}

resource "azurerm_subnet" "private" {
  count                = length(var.subnet_names)
  name                 = "private-${element(var.subnet_names, count.index)}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [element(var.private_subnet_cidrs, count.index)]
}
*/
resource "azurerm_role_assignment" "aks_contributor" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.aks.id
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_virtual_network.main.id
}

resource "azurerm_kubernetes_cluster_node_pool" "fargate" {
  name                  = "fargate"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
//  vnet_subnet_id        = element(azurerm_subnet.private[*].id, 0)
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_kube_config" {
  sensitive = true
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
