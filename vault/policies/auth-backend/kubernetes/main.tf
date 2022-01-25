# resource "vault_auth_backend" "kubernetes" {
#   type        = "kubernetes"
#   path        = "k8s/${var.environment}"
#   description = "${var.description}"
# }

# resource "vault_kubernetes_auth_backend_config" "backend_config" {
#   backend            = "${vault_auth_backend.kubernetes.path}"
#   kubernetes_host    = "${var.kubernetes_host_address}"
#   # kubernetes_ca_cert = "${var.kubernetes_ca_cert}"
#   # token_reviewer_jwt = "${var.kubernetes_token_reviewer_jwt}"
# }

# resource "vault_kubernetes_auth_backend_role" "role" {
#   backend                          = "${vault_auth_backend.kubernetes.path}"
#   role_name                        = "${var.kubernetes_sa_namespace}-${var.environment}-role"
#   bound_service_account_names      = ["${var.kubernetes_sa_name}"]
#   bound_service_account_namespaces = ["${var.kubernetes_sa_namespace}"]

#   token_ttl      = "${var.token_ttl}"
#   token_max_ttl  = "${var.token_max_ttl}"
#   token_policies = "${var.role_policies}"
# }
