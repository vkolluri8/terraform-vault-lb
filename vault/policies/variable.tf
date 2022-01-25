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

variable login_username {
  description = "username to login to vault"
  type        = string
  default     = ""
}
variable login_password {
  description = "password to login to vault"
  type        = string
  default     = ""
}

variable "default_lease_ttl" {
  description = "The default TTL for the issued Vault token. Value shoulde be a valid duration string"
  type        = string
  default     = "24h"
}

variable "max_lease_ttl" {
  description = "The max TTL for the issued Vault token. Value shoulde be a valid duration string"
  type        = string
  default     = "24h"
}

variable "oidc_discovery_url" {
  description = "The OIDC discovery URL, without any .well-known component"
  type        = string
}

variable "oidc_client_id" {
  description = "The OIDC client ID"
  type        = string
}

variable "oidc_client_secret" {
  description = "The OIDC client secret"
  type        = string
}

variable "path" {
  description = "The OIDC authentication backend path"
  type        = string
  default     = "oidc"
}

variable "default_role" {
  description = "The default role to assume if none specified at login"
  type        = string
  default     = ""
}

variable "oidc_scopes" {
  description = "The OIDC scopes to use as claims for the role"
  type        = list
  default     = ["groups"]
}

variable "user_claim" {
  description = "The claim to uniquely identify a user. Maps to the user entity's alias"
  type        = string
  default     = "gmail"
}

variable "groups_claim" {
  description = "The claim to use to uniquely map to a set Vault identity groups using their alias"
  type        = string
  default     = "groups"
}

variable "allowed_redirect_uris" {
  description = "A list of allowed redirect URIs during OIDC login"
  type        = list
  default     = []
}

#approle
variable "app_name" {
  description = "The application name using this AppRole authentication backend"
  type        = string
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


#k8s
# variable "kubernetes_host_address" {
#   description = "The Kubernetes host address"
#   type        = "string"
# }

# # variable "kubernetes_ca_cert" {
# #   description = "The Kubernetes CA certifiate"
# #   type        = "string"
# # }

# variable "kubernetes_sa_namespace" {
#    description = "The Kubernetes service account's namespace attched to the role"
#    type        = "string"
# }

# variable "kubernetes_sa_name" {
#   description = "The Kubernetes service account name attched to the role"
#   type        = "string"
# }


#ldap
# variable "url" {
#   description = "The URL of the LDAP server"
#   type        = "string"
# }

# variable "insecure_tls" {
#   description = "Disables TLS if set to true"
#   type        = "string"
#   default     = false
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


#pki backend

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


#root variables

# variable "default_lease_ttl_pki" {
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
