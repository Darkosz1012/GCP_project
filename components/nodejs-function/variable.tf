variable "gcp_project_id" {
  type        = string
  description = "GCP project id"
  default     = "idyllic-script-371819"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
  default     = "europe-central2"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
  default     = "europe-central2-a"
}


variable "bucket_name" {
  type    = string
  default = "code-bucket-for-function-sdfsdfwerwasdf"
}

variable "object_name" {
  type    = string
  default = "function.zip"
}

variable "code_path" {
  type        = string
  description = "Path to server code which will be compressed and send to cloud storage."
  default     = "./src/*"
}
