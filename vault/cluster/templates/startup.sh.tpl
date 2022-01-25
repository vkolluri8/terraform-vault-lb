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
${config}
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
export VAULT_ADDR=http://127.0.0.1:${vault_port}
EOF

logger 'Setting VAULT_ADDR for this session'
export VAULT_ADDR=http://127.0.0.1:${vault_port}
