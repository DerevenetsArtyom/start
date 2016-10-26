
# declare paths
DB_NAME=$PROJECT_NAME
VIRTUALENV_NAME=$PROJECT_NAME
PROJECT_DIR=/home/vagrant/$PROJECT_NAME
VIRTUALENV_DIR=/home/vagrant/$PROJECT_NAME/env

sudo apt-get install -y build-essential
sudo apt-get install -y gettext
sudo apt-get install -y git

# locale
locale-gen en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

sudo dpkg-reconfigure locales --default-priority

# Postgresql
sudo apt-get install -y postgresql libpq-dev

sudo -u postgres psql -c  "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant $PROJECT_NAME"

# Update Python
sudo add-apt-repository ppa:fkrull/deadsnakes -y
sudo apt-get update
sudo apt-get install python3.5 python3-pip python3.5-dev -y
/home/vagrant/$PROJECT_NAME/env/bin/pip install -r /home/vagrant/$PROJECT_NAME/requirements.txt

# Virtual environment
sudo pip3 install virtualenv
virtualenv $VIRTUALENV_DIR --python=/usr/bin/python3.5

echo "source $VIRTUALENV_DIR/bin/activate" >> ~/.profile
echo "cd ~/$PROJECT_NAME/" >> ~/.profile

# Django project setup
ln -s $PROJECT_DIR/config/local.py ./local_settings.py
mkdir $PROJECT_DIR/$PROJECT_NAME/logs

sudo su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && python $PROJECT_DIR/$PROJECT_NAME/manage.py migrate"

# redis
sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update
sudo apt-get install -y redis-server

# install dependency
sh $PROJECT_DIR/bootstrap_dependency.sh
