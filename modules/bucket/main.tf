resource "null_resource" "local_execution" {
  # provisioner "local-exec" {
  #   # command     = "Compress-Archive -Path ./nodejs-server -DestinationPath ./nodejs-server.zip -Update"
  #   # command     = "echo test"
  #   # interpreter = ["powershell.exe", "-Command"]
  # }
}

resource "google_storage_bucket" "app-bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true


}

resource "google_storage_bucket_object" "app-code" {
  name   = var.object_name
  source = "./nodejs-server.zip"
  bucket = var.bucket_name
  depends_on = [
    null_resource.local_execution,
    google_storage_bucket.app-bucket
  ]

}


