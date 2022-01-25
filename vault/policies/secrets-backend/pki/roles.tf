# resource "vault_pki_secret_backend_role" "role" {
#   count = "${length(var.roles)}"

#   backend = "${vault_pki_secret_backend.pki.path}"

#   name    = "${lookup(var.roles[count.index], "name")}"
#   ttl     = "${lookup(var.roles[count.index], "ttl")}"
#   max_ttl = "${lookup(var.roles[count.index], "max_ttl")}"

#   allow_subdomains = "${lookup(var.roles[count.index], "allow_subdomains", false)}"
#   allowed_domains  = ["${split(",", lookup(var.roles[count.index], "allowed_domains"))}"]

#   allow_ip_sans    = "${lookup(var.roles[count.index], "allow", true)}"
#   allowed_uri_sans = ["${split(",", lookup(var.roles[count.index], "allowed_uri_sans", ""))}"]

#   allow_bare_domains = "${lookup(var.roles[count.index], "allow_bare_domains", false)}"

#   key_type = "rsa"
#   key_bits = 4096
# }
