provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "exemplo" {
  name     = "exemplo-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "exemplo" {
  name                = "exemplo-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.exemplo.location
  resource_group_name = azurerm_resource_group.exemplo.name
}

resource "azurerm_subnet" "exemplo" {
  name                 = "exemplo-subnet"
  resource_group_name  = azurerm_resource_group.exemplo.name
  virtual_network_name = azurerm_virtual_network.exemplo.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "exemplo" {
  name                = "exemplo-public-ip"
  location            = azurerm_resource_group.exemplo.location
  resource_group_name = azurerm_resource_group.exemplo.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "exemplo" {
  name                = "exemplo-nic"
  location            = azurerm_resource_group.exemplo.location
  resource_group_name = azurerm_resource_group.exemplo.name

  ip_configuration {
    name                          = "exemplo-ip"
    subnet_id                     = azurerm_subnet.exemplo.id
    public_ip_address_id          = azurerm_public_ip.exemplo.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb" "exemplo" {
  name                = "exemplo-lb"
  location            = azurerm_resource_group.exemplo.location
  resource_group_name = azurerm_resource_group.exemplo.name

  frontend_ip_configuration {
    name                          = "PublicIPAddress"
    public_ip_address_id          = azurerm_public_ip.exemplo.id
    private_ip_address_allocation = "Dynamic"
  }

  backend_address_pool {
    name = "BackendPool"
  }

  probe {
    name                      = "healthprobe"
    protocol                  = "Http"
    request_path              = "/"
    port                      = var.web_port
    interval_in_seconds       = var.probe_interval_seconds
    number_of_probes          = var.probe_number_of_probes
    timeout_in_seconds        = var.probe_timeout_seconds
    unhealthy_threshold_count = var.probe_unhealthy_threshold_count
  }

  load_balancing_rule {
    name               = var.lb_rule_name
    frontend_port      = var.lb_frontend_port
    backend_port       = var.lb_backend_port
    protocol           = var.lb_protocol
    frontend_ip_config_id   = azurerm_lb.example.frontend_ip_configuration[0].id
    backend_address_pool_id   = azurerm_lb.example.backend_address_pool[0].id
    probe_id           = azurerm_lb.example.probe[0].id

}
