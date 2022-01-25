module "vault_auth_userpass" {
    source = "./auth-backend/userpass"

    login_username          = var.login_username
    login_password          = var.login_password 
    environment             = var.environment
}

module "vault_auth_approle" {
    source = "./auth-backend/approle"

    app_name                = var.app_name
    //cidr_whitelist          = var.cidr_whitelist
    role_policies           = var.role_policies
    environment             = var.environment
    organization            = var.organization
}

# module "vault_auth_k8s" {
#     source = "./auth-backend/kubernetes"

#     kubernetes_host_address         = var.kubernetes_host_address
#     //kubernetes_ca_cert              = var.kubernetes_ca_cert
#     //kubernetes_token_reviewer_jwt   = var.kubernetes_token_reviewer_jwt
#     kubernetes_sa_namespace         = var.kubernetes_sa_namespace
#     kubernetes_sa_name              = var.kubernetes_sa_name
#     environment                     = var.environment
# }

# module "vault_auth_ldap" {
#     source = "./auth-backend/ldap"

#     url                     = var.url
#     insecure_tls            = var.insecure_tls
#     certificate             = var.kubernetes_ca_cert
#     binddn                  = var.binddn
#     bindpass                = var.bindpass
#     userdn                  = var.userdn
#     userattr                = var.userattr
#     upndomain               = var.upndomain
#     groupfilter             = var.groupfilter
#     groupdn                 = var.groupdn
#     groupattr               = var.groupattr
#     environment             = var.environment
# }


module "vault_auth_oidc" {
    source = "./auth-backend/oidc"

    oidc_discovery_url      = var.oidc_discovery_url
    oidc_client_id          = var.oidc_client_id
    oidc_client_secret      = var.oidc_client_secret
    environment             = var.environment
}


#secret-backend
module "vault_secrets_kv" {
    source = "./secrets-backend/kv"

    organization            = var.organization
    environment             = var.environment    
}

# module "vault_secrets_pki" {
#     source = "./secrets-backend/pki"

#     ca_name                 = var.ca_name
#     vault_domain            = var.vault_domain
#     ca_cert_common_name     = var.ca_cert_common_name
#     parent_ca_path          = var.parent_ca_path  
# }