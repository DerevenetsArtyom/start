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

echo "#!/bin/bash 

PROJECT_NAME='$1'\n" > bootstrap.sh

cat basebootstrap.sh  >> bootstrap.sh

