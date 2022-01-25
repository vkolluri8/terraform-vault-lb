# variable "description" {
#   description = "The Kubernetes authentication backend description"
#   type        = "string"
#   default     = "A Kubernetes authentication backend"
# }

# variable "kubernetes_host_address" {
#   description = "The Kubernetes host address"
#   type        = "string"
# }

# # variable "kubernetes_ca_cert" {
# #   description = "The Kubernetes CA certifiate"
# #   type        = "string"
# # }

# variable "kubernetes_sa_name" {
#   description = "The Kubernetes service account name attched to the role"
#   type        = "string"
# }

# variable "kubernetes_sa_namespace" {
#    description = "The Kubernetes service account's namespace attched to the role"
#    type        = "string"
# }

# # variable "kubernetes_token_reviewer_jwt" {
# #   description = "The Kubernetes service account JWT"
# #   type        = "string"
# # }

# variable "token_ttl" {
#   description = "The Vault token TTL"
#   type        = "string"
#   default     = 3600
# }

# variable "token_max_ttl" {
#   description = "The Vault token max TTL"
#   type        = "string"
#   default     = 3600
# }

# variable "environment" {
#   description = "Enter environment to deploy"
#   type        = string
#   default     = ""
# }

# variable "role_policies" {
#   description = "The Kubernetes authentication backend role's policies"
#   type        = "list"
#   default     = []
# }
