variable "description" {
  description = "The AppRole authentication backend description"
  type        = "string"
  default     = "A AppRole authentication backend"
}

variable "organization" {
  description = "Organization"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Enter environment to deploy"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "The application name using this AppRole authentication backend"
  type        = "string"
}

variable "token_ttl" {
  description = "The Vault token TTL"
  type        = "string"
  default     = 3600
}

variable "wrapping_ttl" {
  description = "The Vault wrapped response TTL the secret ID"
  type        = "string"
  default     = 600   # 10mins
}

# variable "cidr_whitelist" {
#   description = "A list of CIDRs to whitelist that can use this authentication backend"
#   type        = "list"
# }

variable "role_policies" {
  description = "The Kubernetes authentication backend role's policies"
  type        = "list"
  default     = []
}
