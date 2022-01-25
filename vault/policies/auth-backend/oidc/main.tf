#oidc
resource "vault_jwt_auth_backend" "oidc" {
  type               = "oidc"
  description        = "Demonstration of the Terraform JWT auth backend"
  oidc_discovery_url = var.oidc_discovery_url
  oidc_client_id     = var.oidc_client_id
  oidc_client_secret = var.oidc_client_secret
  bound_issuer       = var.oidc_discovery_url
  default_role       = "google"
}
