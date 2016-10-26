
# declare paths
DB_NAME=$PROJECT_NAME;
VIRTUALENV_NAME=$PROJECT_NAME;
PROJECT_DIR=/home/vagrant/$PROJECT_NAME;
VIRTUALENV_DIR=/home/vagrant/$PROJECT_NAME/env;

sudo apt-get install -y build-essential;
sudo apt-get install -y git;
sudo apt-get install -y gettext;

# locale
locale-gen en_US.UTF-8;
export LANGUAGE=en_US.UTF-8;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;

sudo dpkg-reconfigure locales --default-priority;

# Update Python
sudo add-apt-repository ppa:fkrull/deadsnakes -y;
sudo apt-get update;
sudo apt-get install python3.5 python3-pip python3.5-dev -y;

# Postgresql
sudo apt-get install -y postgresql libpq-dev

sudo -u postgres psql -c  "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant $PROJECT_NAME"

# Virtual environment
sudo pip3 install virtualenv;
virtualenv $VIRTUALENV_DIR --python=/usr/bin/python3.5;

echo "source $VIRTUALENV_DIR/bin/activate" >> ~/.profile;
echo "cd ~/$PROJECT_NAME/" >> ~/.profile; 

sudo -u postgres psql -c  "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant $PROJECT_NAME"

/home/vagrant/$PROJECT_NAME/env/bin/pip install -r /home/vagrant/$PROJECT_NAME/requirements.txt;

# Django project setup
sudo su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && cd $PROJECT_DIR && django-admin startproject $PROJECT_NAME"

cd $PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME/
mkdir settings

mv settings.py settings/base.py
echo "DB_NAME='$PROJECT_NAME'" >> settings/base.py
cat $PROJECT_DIR/config/setting_default.py >> $PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME/base.py
rm $PROJECT_DIR/config/setting_default.py
cd $PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME/settings

ln -s $PROJECT_DIR/config/local.py ./local_settings.py
mkdir $PROJECT_DIR/$PROJECT_NAME/logs

echo "
from .base import *
from .local_settings import *
" > __init__.py

sudo su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && python $PROJECT_DIR/$PROJECT_NAME/manage.py migrate"

mv $PROJECT_DIR/config/urls.py $PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME/urls.py
sed -i "1 i NAMEDIR=$PROJECT_NAME" $PROJECT_DIR/makefile

# create new bootstrap.sh
rm $PROJECT_DIR/init.sh
sed -i "1 i PROJECT_NAME=$PROJECT_NAME" $PROJECT_DIR/last_middle_bootstrap.sh
mv $PROJECT_DIR/last_middle_bootstrap.sh $PROJECT_DIR/bootstrap.sh

sudo su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && cd $PROJECT_DIR/ && make messages"

# redis
sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update
sudo apt-get install -y redis-server

# install dependency
sh $PROJECT_DIR/bootstrap_dependency.sh
