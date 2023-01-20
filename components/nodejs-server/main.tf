
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}


module "bucket" {
  source      = "../modules/bucket"
  bucket_name = var.bucket_name
  object_name = var.object_name
  location    = var.gcp_region
  code_path   = var.code_path
}

# module "firestore" {
#   source     = "./modules/firestore"
#   project_id = var.gcp_project_id
# }


module "app-engine" {
  source      = "../modules/app-engine"
  project_id  = var.gcp_project_id
  location_id = var.gcp_region
  object_name = var.object_name
  bucket_name = var.bucket_name
  env_variables = {
    port = "8080"
  }
  depends_on = [
    module.bucket
  ]
}
