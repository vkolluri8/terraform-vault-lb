#username & password
login_username          = "user1"
login_password          = "changeme"
environment             = "dev"


#approle
app_name                = ""
//cidr_whitelist          = ""

# #k8s
# kubernetes_host_address         = ""
# //kubernetes_ca_cert              = ""
# //kubernetes_token_reviewer_jwt   = ""
# kubernetes_sa_namespace         = ""
# kubernetes_sa_name              = ""


# #ldap
# url                     = ""
# insecure_tls            = true
# binddn                  = ""
# bindpass                = ""
# userdn                  = ""
# userattr                = ""
# upndomain               = ""
# groupfilter             = ""
# groupdn                 = ""
# groupattr               = ""

#oidc
oidc_discovery_url      = ""
oidc_client_id          = ""
oidc_client_secret      = ""
organization            = ""


# #pki backend polcies
# ca_name                 = ""
# vault_domain            = "https://vault-dev.corp.cvscaremark.com/"
# ca_cert_common_name     = ""
# parent_ca_path          = ""

#common
role_policies             = ["dev", "prod"]
