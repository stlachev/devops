resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.azure_region_name
}

resource "azurerm_virtual_network" "main" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Name = "main"
  }
}

resource "azurerm_subnet" "public_subnet" {
  count                = length(var.subnet_names)
  name                 = "public-${element(var.subnet_names, count.index)}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [element(var.public_subnet_cidrs, count.index)]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "private_subnet" {
  count                = length(var.subnet_names)
  name                 = "private-${element(var.subnet_names, count.index)}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [element(var.private_subnet_cidrs, count.index)]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_public_ip" "nat" {
  name                = "nat-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Name = "nat"
  }
}

resource "azurerm_nat_gateway" "nat" {
  name                = "nat-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
//  public_ip_address_ids = [azurerm_public_ip.nat.id]
  sku_name = "Standard"
  idle_timeout_in_minutes = 10
  //zones                   = ["1"]
  //zones                   = []

  tags = {
    Name = "nat"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "public" {
//  count              = length(var.subnet_names)
  nat_gateway_id     = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "nat-gateway-subnet" {
  count          = length(var.subnet_names)
  subnet_id      = azurerm_subnet.private_subnet[count.index].id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_route_table" "private" {
  name                = "private-route-table"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Name = "private"
  }
}

resource "azurerm_route_table" "public" {
  name                = "public-route-table"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    Name = "public"
  }
}

resource "azurerm_subnet_route_table_association" "public_subnet_association" {
  count              = length(var.subnet_names)
  subnet_id          = azurerm_subnet.public_subnet[count.index].id
  route_table_id     = azurerm_route_table.public.id
}

resource "azurerm_subnet_route_table_association" "private_subnet_association" {
  count              = length(var.subnet_names)
  subnet_id          = azurerm_subnet.private_subnet[count.index].id
  route_table_id     = azurerm_route_table.private.id
}

resource "azurerm_route" "public_route" {
  count                   = length(var.subnet_names)
  name                    = "public-route"
  resource_group_name     = azurerm_resource_group.main.name
  route_table_name        = azurerm_route_table.public.name
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "Internet"
}

resource "azurerm_route" "private_route" {
  count                   = length(var.subnet_names)
  name                    = "private-route"
  resource_group_name     = azurerm_resource_group.main.name
  route_table_name        = azurerm_route_table.private.name
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "VnetLocal" //"VirtualAppliance"
  //next_hop_in_ip_address  = azurerm_nat_gateway.nat.private_ip_address
}
