instance_name           = "vault-non-prod"
project_id              = ""
network                 = ""
host_project_id         = ""
subnet                  = ""
region                  = ""
zone                    = [""]
service_account_name    = ""
ip_address              = ""
domain_name             = ""
vault_storage_bucket    = ""
instance_tags           = ["", ""]
vault_machine_type      = ""
vault_port              = "8200"
lb_port                 = "443"
vault_tls_cert          = "vault-non-prod.crt"
vault_tls_key           = "vault-non-prod.key"
vault_version           = "1.7.1"
instance_base_image     = "debian-cloud/debian-10"
kms_keyring             = "vault-non-prod"
kms_crypto_key          = "vault-non-prod-key"