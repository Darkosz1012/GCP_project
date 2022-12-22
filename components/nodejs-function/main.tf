provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}


module "bucket" {
  source      = "../../modules/bucket"
  bucket_name = var.bucket_name
  object_name = var.object_name
  location    = var.gcp_region
  code_path   = var.code_path
}


module "google-function" {
  source      = "../../modules/google-function"
  bucket_name = var.bucket_name
  object_name = var.object_name
  location_id = var.gcp_region
  project_id  = var.gcp_project_id
}
