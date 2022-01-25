
resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "userpass" {
  depends_on           = ["vault_auth_backend.userpass"]
  path                 = "auth/userpass/users/${var.login_username}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["p1"],
  "password": "${var.login_password}"
}
EOT
}

