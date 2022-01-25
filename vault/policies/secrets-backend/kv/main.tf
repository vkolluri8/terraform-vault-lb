
resource "vault_mount" "kv" {
  path        = "${var.organization}/${var.environment}"
  type        = "kv"
  description = "KV v1 secrets backend for org:${var.organization}, env:${var.environment}"
}
