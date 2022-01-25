variable "path" {
  description = "The OIDC authentication backend path"
  type        = "string"
  default     = "oidc"
}

variable "environment" {
  description = "Enter environment to deploy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The OIDC authentication backend description"
  type        = "string"
  default     = "An OIDC authentication backend"
}

variable "oidc_discovery_url" {
  description = "The OIDC discovery URL, without any .well-known component"
  type        = "string"
}

variable "oidc_client_id" {
  description = "The OIDC client ID"
  type        = "string"
}

variable "oidc_client_secret" {
  description = "The OIDC client secret"
  type        = "string"
}

variable "default_role" {
  description = "The default role to assume if none specified at login"
  type        = "string"
  default     = "default"
}

variable "allowed_redirect_uris" {
  description = "A list of allowed redirect URIs during OIDC login"
  type        = "list"
  default     = []
}

variable "oidc_scopes" {
  description = "The OIDC scopes to use as claims for the role"
  type        = "list"
  default     = ["groups"]
}

variable "user_claim" {
  description = "The claim to uniquely identify a user. Maps to the user entity's alias"
  type        = "string"
  default     = "email"
}

variable "groups_claim" {
  description = "The claim to use to uniquely map to a set Vault identity groups using their alias"
  type        = "string"
  default     = "groups"
}

variable "default_lease_ttl" {
  description = "The default TTL for the issued Vault token. Value shoulde be a valid duration string"
  type        = "string"
  default     = "24h"
}

variable "max_lease_ttl" {
  description = "The max TTL for the issued Vault token. Value shoulde be a valid duration string"
  type        = "string"
  default     = "24h"
}
