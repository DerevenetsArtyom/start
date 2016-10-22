echo "# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.network :forwarded_port, guest: 8000,  host: 8000,  auto_correct: true
  config.vm.network :forwarded_port, guest: 9000,  host: 9000,  auto_correct: true

  config.vm.synced_folder '.', '/home/vagrant/$1'
  config.vm.provision 'shell', path: 'bootstrap.sh', privileged: false

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end
end" > Vagrantfile

echo "#!/bin/bash \n\nPROJECT_NAME='$1'" '''\n
locale-gen en_US.UTF-8;
export LANGUAGE=en_US.UTF-8;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;

sudo dpkg-reconfigure locales --default-priority;

DB_NAME=$PROJECT_NAME
VIRTUALENV_NAME=$PROJECT_NAME

PROJECT_DIR=/home/vagrant/$PROJECT_NAME
VIRTUALENV_DIR=/home/vagrant/$PROJECT_NAME/env

LOCAL_SETTINGS_PATH="/$PROJECT_NAME/project/settings/settings/local.py"

# Update Python
sudo add-apt-repository ppa:fkrull/deadsnakes -y;
sudo apt-get update;
sudo apt-get install python3.5 python3-pip python3.5-dev -y;
sudo apt-get install git -y;
# Postgresql
sudo apt-get install -y postgresql libpq-dev

# Virtual environment
sudo pip3 install virtualenv;
virtualenv $VIRTUALENV_DIR --python=/usr/bin/python3.5;

echo "source $VIRTUALENV_DIR/bin/activate" >> ~/.profile;
echo "cd ~/$PROJECT_NAME/" >> ~/.profile; 
''' > bootstrap.sh

echo "sudo -u postgres psql -c " '"CREATE USER vagrant WITH PASSWORD' "'vagrant';"'"' >> bootstrap.sh
echo 'sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant $PROJECT_NAME"' >> bootstrap.sh
