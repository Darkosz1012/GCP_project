variable "bucket_name" {
  type        = string
  description = "Name of bucket which hold source code object."
}

variable "object_name" {
  type        = string
  description = "Name of bucket object which hold source code for app."
}


variable "location" {
  type = string
}

variable "code_path" {
  type        = string
  description = "Path to server code which will be compressed and send to cloud storage."
}
