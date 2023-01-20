resource "google_service_account" "custom_service_account" {
  account_id   = "my-account"
  display_name = "Custom Service Account"
}

resource "google_project_iam_member" "gae_api" {
  project = google_service_account.custom_service_account.project
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${google_service_account.custom_service_account.email}"
}

resource "google_project_iam_member" "storage_viewer" {
  project = google_service_account.custom_service_account.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.custom_service_account.email}"
}


# data "google_project" "project" {
# }

# resource "google_storage_bucket_iam_member" "app" {
#   bucket = var.bucket_name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
# }

resource "google_app_engine_standard_app_version" "app_v1" {
  version_id     = "v1-${formatdate("DD-MM-YYYY-hh-mm-ss", timestamp())}"
  service        = "default"
  runtime        = "nodejs18"
  instance_class = "F1"

  entrypoint {
    shell = "node ./index.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${var.bucket_name}/${var.object_name}"
    }
  }



  env_variables = var.env_variables

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances      = 1
    max_idle_instances      = 3
    min_pending_latency     = "1s"
    max_pending_latency     = "5s"

    standard_scheduler_settings {
      target_cpu_utilization        = 0.8
      target_throughput_utilization = 0.8
      min_instances                 = var.min_instances
      max_instances                 = var.max_instances
    }
  }

  delete_service_on_destroy = false
  noop_on_destroy           = true
  service_account           = google_service_account.custom_service_account.email


}


# resource "google_app_engine_application" "app" {
#   project     = var.project_id
#   location_id = var.location_id

# }
