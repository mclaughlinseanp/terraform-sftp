#!/usr/bin/env bash

#Install ansible
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible -y

#Install Python-boto
apt-get install python-software-properties -y
apt-get install python-pip -y
pip install -U boto
pip install boto3

#Install some utils
apt-get install curl -y
apt-get install mlocate -y
apt-get install dos2unix -y
apt-get install unzip -y
add-apt-repository ppa:schot/gawk -y
apt-get update -y
apt-get install gawk -y
apt-get install p7zip-full -y
updatedb

#Install AWS CLI
aws_cli_path=/usr/local/bin/ecs-cli
sudo pip install awscli --ignore-installed six
curl -o $aws_cli_path https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
sudo chmod 751 $aws_cli_path
sudo chown vagrant $aws_cli_path

#Install Terraform
terraform_dir=/usr/local/bin/
terraform_package_name=terraform_0.8.5_linux_amd64.zip
sudo curl -o $terraform_dir/$terraform_package_name https://releases.hashicorp.com/terraform/0.8.5/$terraform_package_name
sudo unzip $terraform_dir/$terraform_package_name -d $terraform_dir 
sudo rm $terraform_dir/$terraform_package_name
sudo chmod 751 $terraform_dir
sudo chown vagrant $terraform_dir
export PATH=$PATH:$terraform_dir

#Add the current Vagrant IP addess to known hosts so local provisioning will work
known_hosts_file=~/.ssh/known_hosts
vagrant_ip=192.168.88.101
touch $known_hosts_file
ssh-keygen -R $vagrant_ip
ssh-keyscan -H $vagrant_ip >> $known_hosts_file


