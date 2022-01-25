# resource "vault_jwt_auth_backend_role" "default" {
#   backend = "${vault_jwt_auth_backend.oidc.path}"

#   role_name = "${var.default_role}"
#   role_type = "oidc"

#   allowed_redirect_uris = "${var.allowed_redirect_uris}"

#   bound_audiences = ["${var.oidc_client_id}"]
#   user_claim      = "${var.user_claim}"
#   oidc_scopes     = "${var.oidc_scopes}"
#   groups_claim    = "${var.groups_claim}"
# }