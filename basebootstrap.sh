locale-gen en_US.UTF-8;
export LANGUAGE=en_US.UTF-8;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;

sudo dpkg-reconfigure locales --default-priority;

DB_NAME=$PROJECT_NAME
VIRTUALENV_NAME=$PROJECT_NAME

PROJECT_DIR=/home/vagrant/$PROJECT_NAME
VIRTUALENV_DIR=/home/vagrant/$PROJECT_NAME/env

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

sudo -u postgres psql -c  "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant $PROJECT_NAME"

