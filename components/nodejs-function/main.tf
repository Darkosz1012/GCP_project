provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}


resource "random_id" "id" {
  byte_length = 8
}


module "bucket" {
  source      = "../../modules/bucket"
  bucket_name = "${var.bucket_name}-${var.code_version}"
  object_name = var.object_name
  location    = var.gcp_region
  code_path   = var.code_path
}

module "firestore" {
  source     = "../../modules/firestore"
  project_id = var.gcp_project_id
}

module "google-function" {
  source       = "../../modules/google-function"
  bucket_name  = "${var.bucket_name}-${var.code_version}"
  object_name  = var.object_name
  location_id  = var.gcp_region
  project_id   = var.gcp_project_id
  code_version = var.code_version
  env_variables = {
    GCP_PROJECT = var.gcp_project_id
  }
  depends_on = [
    module.bucket
  ]
}

module "api-gateway" {
  source              = "./modules/api-gateway"
  project_id          = var.gcp_project_id
  location_id         = var.gcp_region
  function_create_uri = module.google-function.function_url
  depends_on = [
    module.google-function
  ]
}


module "monitoring" {
  source = "./modules/function-monitoring"
}
