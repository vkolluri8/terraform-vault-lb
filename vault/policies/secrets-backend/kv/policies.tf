#policies

# Provider R/W
data "vault_policy_document" "provider_rw" {
  rule {
    path         = "${var.organization}/${var.environment}/*"
    capabilities = ["read", "list", "create", "update", "delete"]
    description  = "Provider R/W policy"
  }
}

resource "vault_policy" "provider_rw" {
  name = "provider-rw-policy_kv-${var.organization}-${var.environment}"
  policy = data.vault_policy_document.provider_rw.hcl
}

# Developer Access R/W
data "vault_policy_document" "dev_access_rw" {
  rule {
    path         = "${var.organization}/${var.environment}/*"
    capabilities = ["read", "list", "create", "update", "delete"]
    description  = "Developer access R/W policy"
  }
}

resource "vault_policy" "dev_rw" {
  name = "dev-rw-policy_kv-${var.organization}-${var.environment}"
  policy = data.vault_policy_document.dev_access_rw.hcl
}

# Consumer R/O
data "vault_policy_document" "consumer_ro" {
  rule {
    path         = "${var.organization}/${var.environment}/*"
    capabilities = ["read", "list"]
    description  = "Consumer R/O policy"
  }
}

resource "vault_policy" "consumer_ro" {
  name = "consumer-ro-policy_kv-${var.organization}-${var.environment}"
  policy = data.vault_policy_document.consumer_ro.hcl
}
