#! /usr/bin/env bash
set -xe
set -o pipefail

# Download and install Vault
curl -sLfo /tmp/vault.zip "https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip"
# Unzip without having to apt install unzip
(echo "import sys"; echo "import zipfile"; echo "with zipfile.ZipFile(sys.argv[1]) as z:"; echo '  z.extractall("/tmp")') | python3 - /tmp/vault.zip
install -o0 -g0 -m0755 -D /tmp/vault /usr/local/bin/vault
rm /tmp/vault.zip /tmp/vault

# Give Vault the ability to run mlock as non-root
if ! [[ -x /sbin/setcap ]]; then
  apt install -qq -y libcap2-bin
fi
/sbin/setcap cap_ipc_lock=+ep /usr/local/bin/vault

# Add Vault user
useradd -d /etc/vault.d -s /bin/false vault

logger 'Creating Vault configuration file'
mkdir -p /etc/vault.d
cat > /etc/vault.d/vault.hcl << EOF

# Enable HA backend storage with GCS
storage "gcs" {
  bucket    = "${vault_tls_bucket}"
  ha_enabled = "true"
}


# Create local non-TLS listener
listener "tcp" {
  address     = "0.0.0.0:${vault_port}"
  tls_disable = "true"
}

seal "gcpckms" {
  project     = "${kms_project}"
  region      = "${kms_location}"
  key_ring    = "${kms_keyring}"
  crypto_key  = "${kms_crypto_key}"
}

# Enable the UI
ui = true

api_addr = "http://INTERNAL_IP:8200"
EOF

internal_ip=`hostname -i`
sed -i "s/INTERNAL_IP/$internal_ip/g" /etc/vault.d/vault.hcl

logger 'Creating Vault systemd service'
mkdir -p /etc/systemd/system
mkdir -p /logs/vault
cat > /etc/systemd/system/vault.service << EOF
[Unit]
Description=vault service
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl

[Service]
EnvironmentFile=-/etc/sysconfig/vault
Environment=GOMAXPROCS=2
Restart=on-failure
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
LimitMEMLOCK=infinity
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM

[Install]
WantedBy=multi-user.target
EOF

logger 'Starting Vault service'
systemctl start vault.service

logger 'Enabling automatic restart'
systemctl enable vault.service

logger 'Setting global value for VAULT_ADDR'
mkdir -p /etc/profile.d/
cat > /etc/profile.d/vault.sh << EOF
export VAULT_ADDR=http://127.0.0.1:8200
EOF

logger 'Setting VAULT_ADDR for this session'
export VAULT_ADDR=http://127.0.0.1:8200

logger 'Waiting for Vault service to become active'
while true; do
    if [ $(systemctl is-active vault.service) == "active" ]; then
        break
    fi
    sleep 1
done

logger 'Sleeping for 10 seconds for Vault to become available'
sleep 10

logger 'Attempting Init'
mkdir -p /etc/vault
vault operator init > /etc/vault/init.file