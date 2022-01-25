variable "project_id" {
  type = string
  description = "ID of the project in which to create resources and add IAM bindings."
}
variable "vault_storage_bucket" {
  type        = string
  description = "Storage bucket name where the backend is configured. This bucket will not be created in this module"
}