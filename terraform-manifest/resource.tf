resource "azurerm_resource_group" "my_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "my_svc_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  os_type             = "Linux"
  sku_name            = "P0v3"
}

resource "azurerm_linux_web_app" "my_web_app" {
  name                = var.web_app_name
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  service_plan_id     = azurerm_service_plan.my_svc_plan.id
  

  site_config {
    always_on = false
    #linux_fx_version = "DOCKER|${var.docker_image}" # Docker image from Docker Hub
  }
  app_settings = {
    DOCKER_CUSTOM_IMAGE_NAME = var.docker_image  # Here you specify the Docker image
    WEBSITES_CONTAINER_START_TIME_LIMIT = "1800"  # Optional: Specify start time if needed
  }
}
/*output "web_app_url" {
  value = azurerm_linux_web_app.my_web_app.default_site_hostname
}*/
output "web_app_url" {
  value = "https://${azurerm_linux_web_app.my_web_app.name}.azurewebsites.net"
}
# Create a deployment slot for the web app (e.g., a staging slot)
resource "azurerm_linux_web_app_slot" "my_web_app_slot" {
  name                = "${azurerm_linux_web_app.my_web_app.name}-staging"  # Staging slot name
  app_service_id = azurerm_linux_web_app.my_web_app.id  # Same service plan as the main app

  site_config {
    always_on = false
  }

  app_settings = {
    DOCKER_CUSTOM_IMAGE_NAME = var.docker_image_v3  # Docker image for the slot
  }
}

output "web_app_slot_url" {
  value = "https://${azurerm_linux_web_app_slot.my_web_app_slot.name}.azurewebsites.net"
}
