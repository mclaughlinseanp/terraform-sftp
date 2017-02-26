#!/bin/bash -e

environment=$1
ansible_vault_password=$2

echo "environment=$environment"
echo "ansible_vault_password=$ansible_vault_password"

function cleanup {
	rm -f "$ansible_vault_password_file" || true
}

ansible_vault_password_file="/var/tmp/vault_pass.txt"

# Create a temp file with the vault password
cat >"$ansible_vault_password_file" <<EOL
$ansible_vault_password
EOL

cd "/vagrant/anisble/"

#We need to remove everything except rw permissions for current user for Ansible to trust the password file
chmod 600 "$ansible_vault_password_file"
ansible-playbook -i inventory -l $environment sftp-playbook.yml --vault-password-file "$ansible_vault_password_file" -vvv

cleanup
trap cleanup EXIT