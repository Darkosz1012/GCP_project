
resource "google_service_account" "custom_service_account" {
  account_id   = "function-account"
  display_name = "Custom Service Account"
}

# resource "google_project_iam_member" "gae_api" {
#   project = google_service_account.custom_service_account.project
#   role    = "roles/compute.networkUser"
#   member  = "serviceAccount:${google_service_account.custom_service_account.email}"
# }

resource "google_project_iam_member" "storage_viewer" {
  project = google_service_account.custom_service_account.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.custom_service_account.email}"
}


resource "google_project_service" "run" {
  project                    = var.project_id
  service                    = "run.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "cloudfunctions" {
  project                    = var.project_id
  service                    = "cloudfunctions.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "artifactregistry" {
  project                    = var.project_id
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = true
}

resource "google_cloudfunctions2_function" "function" {
  name        = "function-v2"
  location    = var.location_id
  description = "a new function"

  build_config {
    runtime     = "nodejs18"
    entry_point = "create" # Set the entry point 
    source {
      storage_source {
        bucket = var.bucket_name
        object = var.object_name
      }
    }
  }

  service_config {
    min_instance_count    = var.min_instances
    max_instance_count    = var.max_instances
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.custom_service_account.email
  }


  depends_on = [
    google_project_service.cloudfunctions,
    google_project_service.run,
    google_project_service.artifactregistry
  ]
}


resource "google_cloudfunctions2_function_iam_member" "invoker" {
  project        = google_cloudfunctions2_function.function.project
  cloud_function = google_cloudfunctions2_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
