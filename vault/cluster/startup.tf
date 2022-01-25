# Compile the startup script. This script installs and configures Vault and all
# dependencies.

data "template_file" "vault-startup-script" {
  template = file("${path.module}/templates/startup.sh.tpl")

  vars = {
    config                  = data.template_file.vault-config.rendered
    service_account_email   = var.vault_service_account_email
    vault_args              = var.args
    vault_port              = var.vault_port
    vault_version           = var.vault_version
  }
}

# Compile the Vault configuration.
data "template_file" "vault-config" {
  template = file(format("%s/templates/config.hcl.tpl", path.module))

  vars = {
    kms_project                              = var.project_id
    kms_location                             = var.region
    kms_keyring                              = var.kms_keyring
    kms_crypto_key                           = var.kms_crypto_key
    vault_tls_bucket                         = local.vault_tls_bucket
    vault_port                               = var.vault_port
  }
}