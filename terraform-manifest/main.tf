/*# Create Resource Group
resource "azurerm_resource_group" "my_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create App Service Plan (Pricing tier)
resource "azurerm_app_service_plan" "my_svc_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  kind                = "Linux"  # Specify Linux because we are using Docker
  reserved            = true     # This tells Azure to run the service on Linux
  sku {
    tier = "Free"
    size = var.sku  # Basic pricing tier
  }
}

# Create Web App (App Service) with Docker container
resource "azurerm_linux_web_app" "my_web_app" {
  name                = var.web_app_name
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  app_service_plan_id = azurerm_app_service_plan.my_svc_plan.id

  # Docker container settings
  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"  # Docker image from Docker Hub
  }

  # Optional: App settings (Environment Variables)
  app_settings = {
    "WEBSITES_PORT" = "80"  # Expose the container on port 80
  }
}

# Output the web app URL
output "web_app_url" {
  value = azurerm_web_app.my_web_app.default_site_hostname
}

resource "azurerm_web_app" "name" {
  
}
*/