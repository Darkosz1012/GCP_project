variable "project_id" {
  type = string
}


variable "location_id" {
  type = string
}

variable "api_config_id_prefix" {
  type    = string
  default = "api"
}

variable "api_id" {
  type    = string
  default = "test-api"
}


variable "gateway_id" {
  type    = string
  default = "test-gateway"
}

variable "display_name" {
  type    = string
  default = "test"
}

variable "api_gateway_container_id" {
  type    = string
  default = "test-api-gateway-container"
}




variable "function_create_uri" {
  type = string
}
