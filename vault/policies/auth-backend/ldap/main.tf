# resource "vault_ldap_auth_backend" "ldap" {
#     path        = "ldap/${var.environment}"
#     description = "${var.description}"

#     url          = "${var.url}"
#     # insecure_tls = "${var.insecure_tls}"
#     # certificate  = "${var.kubernetes_ca_cert}"
    
#     binddn   = "${var.binddn}"
#     bindpass = "${var.bindpass}"

#     userdn      = "${var.userdn}"
#     userattr    = "${var.userattr}"
#     upndomain   = "${var.upndomain}"

#     groupdn     = "${var.groupdn}"
#     groupfilter = "${var.groupfilter}"
#     groupattr   = "${var.groupattr}"
   
#     token_ttl     = "${var.token_ttl}"
#     token_max_ttl = "${var.token_max_ttl}"
# }
