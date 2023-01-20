resource "google_project_service" "firestore" {
  project                    = var.project_id
  service                    = "firestore.googleapis.com"
  disable_dependent_services = true
}
resource "null_resource" "local_execution" {
  triggers = {
    new_bucket = var.project_id
  }
  provisioner "local-exec" {
    command     = "gcloud alpha firestore databases update --type=firestore-native --project=${var.project_id}"
    interpreter = ["powershell.exe", "-Command"]
  }
  depends_on = [
    google_project_service.firestore
  ]
}
