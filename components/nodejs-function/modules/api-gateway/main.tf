

resource "google_project_service" "api_gw_service" {
  project                    = var.project_id
  service                    = "apigateway.googleapis.com"
  disable_dependent_services = true
}


resource "google_project_service" "servicecontrol_service" {
  project                    = var.project_id
  service                    = "servicecontrol.googleapis.com"
  disable_dependent_services = true
}



resource "google_api_gateway_api" "api_gw" {
  provider     = google-beta
  api_id       = var.api_gateway_container_id
  project      = var.project_id
  display_name = var.display_name
  depends_on = [
    google_project_service.api_gw_service
  ]
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider             = google-beta
  api                  = google_api_gateway_api.api_gw.api_id
  api_config_id_prefix = var.api_config_id_prefix
  project              = var.project_id
  display_name         = var.display_name
  # address: https://${var.location_id}-${var.project_id}.cloudfunctions.net/${var.endpoint}
  openapi_documents {
    document {
      path = "openapi.yaml"
      contents = base64encode(<<-EOF
            swagger: '2.0'
            info:
                title: test-api
                version: 1.0.0
            schemes:
                - https
            produces:
                - application/json
            paths:
                /api/create:
                    get:
                        summary: create
                        operationId: create1
                        x-google-backend:
                            address: ${var.function_create_uri}
                        responses:
                            200:
                                description: 'Successful response'
                                schema:
                                    type: string
                    post:
                        summary: create
                        operationId: create2
                        x-google-backend:
                            address: ${var.function_create_uri}
                        responses:
                            200:
                                description: 'Successful response'
                                schema:
                                    type: string
    EOF
      )
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "gw" {
  provider = google-beta
  region   = "europe-west1" #var.location_id
  project  = var.project_id


  api_config = google_api_gateway_api_config.api_cfg.id

  gateway_id   = var.gateway_id
  display_name = var.display_name

  depends_on = [google_api_gateway_api_config.api_cfg]
}
