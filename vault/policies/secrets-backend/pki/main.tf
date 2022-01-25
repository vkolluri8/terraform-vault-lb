# resource "vault_pki_secret_backend" "pki" {
#   path        = "pki/${var.ca_name}"
#   description = "pki secret backend"

#   default_lease_ttl_seconds = "${var.default_lease_ttl}"
#   max_lease_ttl_seconds     = "${var.max_lease_ttl}"
# }

# resource "vault_pki_secret_backend_config_urls" "config_urls" {
#   depends_on = ["vault_pki_secret_backend.pki"]
  
#   backend = "${vault_pki_secret_backend.pki.path}"

#   issuing_certificates    = ["https://${var.vault_domain}/v1/pki/${var.ca_name}/ca"]
#   crl_distribution_points = ["https://${var.vault_domain}/v1/pki/${var.ca_name}/crl"]
# }

# resource "vault_pki_secret_backend_crl_config" "crl_config" {
#   depends_on = ["vault_pki_secret_backend.pki"]
  
#   backend = "${vault_pki_secret_backend.pki.path}"
  
#   expiry  = "72h"
#   disable = false
# }

# resource "vault_pki_secret_backend_intermediate_cert_request" "csr" {
#   depends_on = ["vault_pki_secret_backend.pki"]

#   backend = "${vault_pki_secret_backend.pki.path}"

#   type        = "internal"
#   common_name = "${var.ca_cert_common_name}"
#   format      = "pem"
#   key_type    = "rsa"
#   key_bits    = "4096"
# }

# resource "vault_pki_secret_backend_root_sign_intermediate" "signed_cert" {
#   depends_on = ["vault_pki_secret_backend_intermediate_cert_request.csr"]

#   backend = "${var.parent_ca_path}"

#   csr         = "${vault_pki_secret_backend_intermediate_cert_request.csr.csr}"
#   common_name = "${var.ca_cert_common_name}"
#   ttl         = "${var.ca_cert_ttl}"
#   format      = "pem"
# }

# resource "vault_pki_secret_backend_intermediate_set_signed" "set_signed_cert" {
#   depends_on = ["vault_pki_secret_backend_root_sign_intermediate.signed_cert"]

#   backend = "${vault_pki_secret_backend.pki.path}"

#   certificate = "${vault_pki_secret_backend_root_sign_intermediate.signed_cert.certificate}"
# }




# #pki root
# resource "vault_pki_secret_backend" "pki" {
#   path        = "pki-root"
#   description = "The root CA"

#   default_lease_ttl_seconds = "${var.default_lease_ttl}"
#   max_lease_ttl_seconds     = "${var.max_lease_ttl}"
# }

# resource "vault_pki_secret_backend_config_urls" "config_urls" {
#   depends_on = ["vault_pki_secret_backend.pki"]
  
#   backend = "${vault_pki_secret_backend.pki.path}"

#   issuing_certificates    = ["https://${var.vault_domain}/v1/pki-root/ca"]
#   crl_distribution_points = ["https://${var.vault_domain}/v1/pki-root/crl"]
# }

# resource "vault_pki_secret_backend_crl_config" "crl_config" {
#   depends_on = ["vault_pki_secret_backend.pki"]
  
#   backend = "${vault_pki_secret_backend.pki.path}"
  
#   expiry  = "63072000s" # 2 years
#   disable = false
# }

# resource "vault_pki_secret_backend_root_cert" "cert" {
#   depends_on = ["vault_pki_secret_backend.pki"]

#   backend = "${vault_pki_secret_backend.pki.path}"

#   type        = "internal"
#   common_name = "${var.root_ca_cert_common_name}"
#   ttl         = "${var.root_ca_cert_ttl}"
#   format      = "pem"
#   key_type    = "rsa"
#   key_bits    = "4096"
# }
