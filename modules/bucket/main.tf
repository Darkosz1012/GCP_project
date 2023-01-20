resource "null_resource" "local_execution" {
  triggers = {
    new_bucket = var.bucket_name
  }
  provisioner "local-exec" {
    command     = "Compress-Archive -Path ${var.code_path} -DestinationPath ./${var.object_name} -Update"
    interpreter = ["powershell.exe", "-Command"]
  }
}
# resource "null_resource" "local_execution" {

#   provisioner "local-exec" {
#     interpreter = ["PowerShell", "-Command"]
#     command     = "./create_zip.ps1"
#   }

# }

resource "google_storage_bucket" "app-bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true


}

resource "google_storage_bucket_object" "app-code" {
  name   = var.object_name
  source = "./${var.object_name}"
  bucket = var.bucket_name
  depends_on = [
    null_resource.local_execution,
    google_storage_bucket.app-bucket
  ]

}


