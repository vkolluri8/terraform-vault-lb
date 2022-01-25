#Approle

resource "vault_auth_backend" "approle" {
  type = "approle"
  path        = "approle/${var.environment}"
  description = "A AppRole authentication backend"
}

resource "vault_approle_auth_backend_role" "role" {
  backend               = "${vault_auth_backend.approle.path}"
  role_name             = "${var.app_name}-${var.environment}-role"
  //secret_id_bound_cidrs = ["${var.cidr_whitelist}"]

  token_ttl      = "${var.token_ttl}"
  token_policies = "${var.role_policies}"

}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = "${vault_auth_backend.approle.path}"
  role_name = "${vault_approle_auth_backend_role.role.role_name}"
#   cidr_list = ["${var.cidr_whitelist}"]
#   wrapping_ttl = "${var.wrapping_ttl}"
}
