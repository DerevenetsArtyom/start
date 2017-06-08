echo "# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty32'

  config.vm.network :forwarded_port, guest: 8000,  host: 8000,  auto_correct: true
  config.vm.network :forwarded_port, guest: 9000,  host: 9000,  auto_correct: true

  config.vm.synced_folder '.', '/home/vagrant/$1'
  config.vm.provision 'shell', path: 'bootstrap.sh', privileged: false

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end
end" > Vagrantfile

sed -i "1 i #!/bin/bash " bootstrap.sh
sed -i "1 i PROJECT_NAME='$1'" bootstrap.sh

echo "
import multiprocessing
import os

os.environ['DJANGO_SETTINGS_MODULE'] = '$1.settings'

bind = '0.0.0.0:8833'
workers = multiprocessing.cpu_count() * 4 + 1
" > config/gunicorn.conf.py
