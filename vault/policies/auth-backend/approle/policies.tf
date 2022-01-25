
# approle policies
data "vault_policy_document" "approle" {
  rule {
    path         = "${var.organization}/${var.environment}/*"
    capabilities = ["read", "list"]
    description  = "approle R/W policy"
  }
}

resource "vault_policy" "approle" {
  name = "approle-${var.organization}-${var.environment}"
  policy = data.vault_policy_document.approle.hcl
}