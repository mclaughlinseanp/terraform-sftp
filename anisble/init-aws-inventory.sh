
aws_access_key_id=$1
aws_secret_access_key=$2
aws_region=$3

ansible_cfg_path=/etc/ansible/ansible.cfg
ecs_py_path=/etc/ansible/ec2.py
ecs_ini_path=/etc/ansible/ec2.ini

aws_credentials_path=~/.aws/credentials
aws_config_path=~/.aws/config
aws_profile=terraform-sftp

mkdir -p ~/.aws/ && touch $aws_credentials_path

cat >> $aws_credentials_path <<EOF

[$aws_profile]
aws_access_key_id=$aws_access_key_id
aws_secret_access_key=$aws_secret_access_key

EOF

cat >> $aws_config_path <<EOF

[$aws_profile]
region=$aws_region

EOF


curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -o $ecs_py_path
curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini -o $ecs_ini_path

#Disable inventory search in EDS and ElasicCache in the event the key pair doesn't have access - Not needed for SFTP Server inventory
sed -i -e 's@#elasticache = False@'"elasticache = False"'@g' $ecs_ini_path
sed -i -e 's@#rds = False@'"rds = False"'@g' $ecs_ini_path

#Disable host key checking to avoid prompts to accept new SSH hosts
sed -i -e 's@#host_key_checking = False@'"host_key_checking = False"'@g' $ansible_cfg_path

chmod 710 $ecs_py_path
chmod 710 $ecs_ini_path

export ANSIBLE_HOSTS=$ecs_py_path
export EC2_INI_PATH=$ecs_ini_path


python $ecs_py_path --profile $aws_profile --list


#TODO...Incomplete script
