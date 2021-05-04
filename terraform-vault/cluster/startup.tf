# Compile the startup script. This script installs and configures Vault and all
# dependencies.

data "template_file" "vault-startup-script" {
  template = file("${path.module}/templates/startup.sh")

  vars = {
    service_account_email   = var.vault_service_account_email
    vault_args              = var.args
    vault_port              = var.vault_port
    vault_proxy_port        = var.vault_proxy_port
    vault_tls_bucket        = local.vault_tls_bucket
    api_addr                = local.ip_address
    kms_project             = var.project_id
    kms_location            = var.region
    kms_keyring             = var.kms_keyring
    kms_crypto_key          = var.kms_crypto_key
    vault_version           = var.vault_version
  }
}
