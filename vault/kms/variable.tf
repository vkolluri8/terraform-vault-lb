variable "project_id" {
  type = string
  description = "ID of the project in which to create resources and add IAM bindings."
}

variable "region" {
  type    = string
  default = "us-east1"
  description = "Region in which to create resources."
}

variable "kms_keyring" {
  type        = string
  default = ""
  description = "keyring is passing from tf vars to unseal multinode vault"
}

variable "kms_crypto_key" {
  type        = string
  default = ""
  description = "crypto key is passing from tf vars to unseal multinode vault"
}

variable "kms_protection_level" {
  type    = string
  default = "software"
  description = "The protection level to use for the KMS crypto key."
}