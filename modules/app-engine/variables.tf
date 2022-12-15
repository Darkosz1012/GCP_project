variable "project_id" {
  type = string
}

variable "location_id" {
  type = string
}

variable "bucket_name" {
  type        = string
  description = "Name of bucket which hold source code object."
}

variable "object_name" {
  type        = string
  description = "Name of bucket object which hold source code for app."
}

variable "env_variables" {
  type        = map(any)
  description = "Environment variable provide to app."
}

variable "min_instances" {
  type    = number
  default = 0
}

variable "max_instances" {
  type    = number
  default = 3
}
