
# Variables
variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "my-resource-group"
}

variable "app_service_plan_name" {
  default = "my-app-service-plan"
}

variable "web_app_name" {
  default = "my-web-app"
}

variable "docker_image" {
  default = "dockerhub_username/your-image:latest" # Replace with your Docker Hub image
}
variable "docker_image_v3" {
  default = "dockerhub_username/your-image:latest" # Replace with your Docker Hub image
}

variable "sku" {
  default = "B1" # Pricing tier (Basic)
}