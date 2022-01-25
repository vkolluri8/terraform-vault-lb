data "google_compute_network" "vault" {
  name    = var.network
  project = var.host_project_id
}

data "google_compute_subnetwork" "vault" {
  name    = var.subnet
  project = var.host_project_id
  region  = var.region
}

module "vault_cluster" {
  source = "../cluster"

  instance_name               = var.instance_name
  project_id                  = var.project_id
  host_project_id             = var.host_project_id
  subnet                      = data.google_compute_subnetwork.vault.self_link
  ip_address                  = var.ip_address
  vault_service_account_email = var.service_account_name
  load_balancing_scheme       = "INTERNAL"
  region                      = var.region
  domain_name                 = var.domain_name
  network                     = var.network
  vault_storage_bucket        = var.vault_storage_bucket
  instance_base_image         = var.instance_base_image
  instance_tags               = var.instance_tags
  zones                       = var.zones
  vault_machine_type          = var.vault_machine_type
  vault_port                  = var.vault_port
  lb_port                     = var.lb_port
  vault_tls_cert              = var.vault_tls_cert
  vault_tls_key               = var.vault_tls_key
  vault_version               = var.vault_version
  kms_keyring                 = var.kms_keyring
  kms_crypto_key              = var.kms_crypto_key
  zone                        = var.zone
}
