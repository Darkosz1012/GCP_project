variable "gcp_project_id" {
  type        = string
  description = "GCP project id"
  default     = "unique-highway-371216"
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
  default = "code-bucket-asdfgewrsdf"
}

variable "object_name" {
  type    = string
  default = "node-server.zip"
}
