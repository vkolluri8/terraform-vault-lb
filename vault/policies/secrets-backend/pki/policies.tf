# # Base policy
# data "vault_policy_document" "base_policy" {
#   rule {
#     path         = "pki/${var.ca_name}/*"
#     capabilities = ["read", "list"]
#     description  = "RO policy for PKI 'pki/${var.ca_name}'"
#   }

#   rule {
#     path         = "pki/${var.ca_name}/revoke"
#     capabilities = ["create", "read", "update", "delete", "list"]
#     description  = "Revoke policy for PKI 'pki/${var.ca_name}'"
#   }
# }

# resource "vault_policy" "base_policy" {
#   name   = "pki-${var.ca_name}-base-policy"
#   policy = "${data.vault_policy_document.base_policy.hcl}"
# }

# # Provider certificate R/W
# data "vault_policy_document" "cert_policy" {
#   count =  "${length(var.roles)}"

#   rule {
#     path         = "pki/${var.ca_name}/issue/${lookup(var.roles[count.index], "name")}"
#     capabilities = ["create", "update"]
#     description  = "Policy to generate/issue certificates for PKI 'pki/${var.ca_name}' role '${lookup(var.roles[count.index], "name")}'"
#   }

#   rule {
#     path         = "pki/${var.ca_name}/sign/${lookup(var.roles[count.index], "name")}"
#     capabilities = ["create", "update"]
#     description  = "Policy to sign certificates from a CSR for PKI 'pki/${var.ca_name}' role '${lookup(var.roles[count.index], "name")}'"
#   }
# }

# resource "vault_policy" "cert_policy" {
#   count =  "${length(var.roles)}"

#   name   = "pki-${var.ca_name}-role-${lookup(var.roles[count.index], "name")}-certificate-generation-policy"
#   policy = "${data.vault_policy_document.cert_policy.*.hcl[count.index]}"
# }
