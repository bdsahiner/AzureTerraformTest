resource "azurerm_resource_group" "berkanRGtest" {
  name     = var.resource_group_name
  location = var.location_name
  tags = {
    environment = "dev"
  }
}
/*
resource "azurerm_virtual_network" "berkanVNtest" {
  name                = var.virtual_network_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  address_space       = var.AdressBlock
  depends_on = [
    azurerm_resource_group.berkanRGtest
  ]
  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "berkanSNtest" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  depends_on           = [azurerm_resource_group.berkanRGtest]
}

resource "azurerm_network_security_group" "berkanNSGtest" {
  name                = var.network_interface_name
  location            = var.location_name
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "berkanSRtest1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [azurerm_resource_group.berkanRGtest]

  tags = {
    environment = "dev"
  }
} 

resource "azurerm_subnet_network_security_group_association" "berkanSNSGAtest" {
  subnet_id                 = azurerm_subnet.berkanSNtest.id
  network_security_group_id = azurerm_network_security_group.berkanNSGtest.id
}

resource "azurerm_public_ip" "berkanPItest" {
  name                = var.public_ip_address_name
  resource_group_name = var.resource_group_name
  location            = var.location_name
  allocation_method   = "Dynamic"
  depends_on          = [azurerm_resource_group.berkanRGtest]
  tags = {
    environment = "dev"
  }
} 

resource "azurerm_network_interface" "berkanNItest" {
  name                = var.network_interface_name
  location            = var.location_name
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.berkanSNtest.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.berkanPItest.id
  }
  depends_on = [
    azurerm_resource_group.berkanRGtest,
    azurerm_public_ip.berkanPItest,
    azurerm_subnet.berkanSNtest,
  ]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_container_group" "berkanCGtest" {
  name                = "example-continst"
  location            = var.location_name
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = "unique-aci-label"
  os_type             = "Linux"
  depends_on          = [azurerm_resource_group.berkanRGtest]

  container {
    name   = "hello-world"
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      "NGINX_HOST" = "localhost"
      "NGINX_PORT" = "80"
    }

    commands = [
      "/bin/sh", "-c", "echo 'Hello, World!' > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'"
    ]
  }

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "dev"
  }
}
*/
resource "azurerm_container_registry" "berkanACRtesting" {
  name                = "berkanacrtesting"
  resource_group_name = var.resource_group_name
  location            = var.location_name
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_container_group" "berkanContainerGroupTesting" {
  name                = "berkancontgro"
  location            = var.location_name
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = "acicontainergroup"
  os_type             = "Linux"

  image_registry_credential {
    server   = "berkanacrtesting.azurecr.io"
    username = "berkanacrtesting"
    password = "*******"
  }

  container {
    name   = " "
    image  = " "
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  container {
    name   = " "
    image  = " "
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3003
      protocol = "TCP"
    }
  }

  container {
    name   = " "
    image  = " "
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3006
      protocol = "TCP"
    }
  }
}

resource "azurerm_log_analytics_workspace" "berkanLAWtest" {
  name                = var.log_analytics_workspace_name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "berkanCAEtest" {
  name                       = var.container_app_environment_name
  location                   = var.location_name
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.berkanLAWtest.id
  depends_on                 = [azurerm_resource_group.berkanRGtest]
}
/*
resource "docker_image" "berkanrjs" {
  name = "berkanrjs:latest"
}

resource "docker_container" "foo" {
  image = docker_image.berkanrjs_id
  name  = "foo"
} */