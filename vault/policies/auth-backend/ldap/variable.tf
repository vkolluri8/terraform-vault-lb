# variable "path" {
#   description = "The LDAP authentication backend path. Path is appended to the prefix ldap/"
#   type        = "string"
# }

# variable "description" {
#   description = "The LDAP authentication backend description"
#   type        = "string"
#   default     = "A LDAP authentication backend"
# }

# variable "environment" {
#   description = "Enter environment to deploy"
#   type        = string
#   default     = ""
# }

# variable "url" {
#   description = "The URL of the LDAP server"
#   type        = "string"
# }

# variable "kubernetes_ca_cert" {
#   description = "The Kubernetes CA certifiate"
#   type        = "string"
# }

# variable "insecure_tls" {
#   description = "Disables TLS if set to true"
#   type        = "string"
#   default     = false
# }

# variable "certificate" {
#   description = "CA certificate to use when verifying LDAP server certificate, must be x509 PEM encoded."
#   type        = "string"
#   default     = ""
# }

# variable "binddn" {
#   description = "Distinguished name of object to bind when performing user and group search"
#   type        = "string"
# }

# variable "bindpass" {
#   description = "Password to use along with `binddn` when performing user search"
#   type        = "string"
# }

# variable "userdn" {
#   description = "Base DN under which to perform user search"
#   type        = "string"
# }

# variable "userattr" {
#   description = "Attribute on user attribute object matching the username passed when authenticating"
#   type        = "string"
# }

# variable "upndomain" {
#   description = "userPrincipalDomain used to construct the UPN string for the authenticating user"
#   type        = "string"
# }

# variable "groupfilter" {
#   description = "Go template used to construct group membership query"
#   type        = "string"
#   default     = "(|(memberUid={{.Username}})(member={{.UserDN}})(uniqueMember={{.UserDN}}))"
# }

# variable "groupdn" {
#   description = "LDAP search base to use for group membership search"
#   type        = "string"
#   default     = ""
# }

# variable "groupattr" {
#   description = "LDAP attribute to follow on objects returned by groupfilter"
#   type        = "string"
#   default     = ""
# }

# variable "token_ttl" {
#   description = "Vault token refresh TTL"
#   type        = "string"
#   default     = "86400"
# }

# variable "token_max_ttl" {
#   description = "Vault token TTL"
#   type        = "string"
#   default     = "86400"
# }
