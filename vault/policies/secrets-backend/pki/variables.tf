# variable "vault_domain" {
#   description = "The Vault domain where the root CA is hosted. Do not include http:// or https://"
#   type        = "string"
# }

# variable "parent_ca_path" {
#   description = "The parent CA path for this intermediate CA"
#   type        = "string"
# }

# variable "ca_name" {
#   description = "The intermediate CA Name. Name is appended to the path"
#   type        = "string"
# }

# variable "default_lease_ttl" {
#   description = "The engine's default lease TTL in seconds. Default 2 years"
#   type        = "string"
#   default     = 63072000
# }

# variable "max_lease_ttl" {
#   description = "The engine's maximum lease TTL in seconds. Default 2 years"
#   type        = "string"
#   default     = 63072000
# }

# variable "ca_cert_ttl" {
#   description = "The CA certificate lease TTL in seconds. Default 2 years"
#   type        = "string"
#   default     = 63072000
# }

# variable "ca_cert_common_name" {
#   description = "The CA certificate common name"
#   type        = "string"
# }

# variable "roles" {
#   description = "A list of roles for ths CA. A role is a map with the appropriate parameters"
#   type        = "list"
#   default     = []
# }


# #root variables
# variable "vault_domain" {
#   description = "The Vault domain where the root CA is hosted. Do not include http:// or https://"
#   type        = "string"
# }

# variable "default_lease_ttl" {
#   description = "The engine's default lease TTL in seconds. Default 5 years"
#   type        = "string"
#   default     = 157680000
# }

# variable "max_lease_ttl" {
#   description = "The engine's maximum lease TTL in seconds. Default 10 years"
#   type        = "string"
#   default     = 315360000
# }

# variable "root_ca_cert_common_name" {
#   description = "The root CA certificate common name"
#   type        = "string"
# }

# variable "root_ca_cert_ttl" {
#   description = "The root CA certificate lease TTL in seconds. Default 10 years"
#   type        = "string"
#   default     = 315360000
# }
