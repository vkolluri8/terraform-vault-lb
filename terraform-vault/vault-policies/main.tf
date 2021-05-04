#This script will run after vault setup, its not part of vault tf script

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "student" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${var.login_username}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "password": "${var.login_password}"
}
EOT
}