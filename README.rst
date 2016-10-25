######
django-bower-plate
######

********
Features
********
* django project
* vagrant
* celery
* django-rest-framework
* redis
* psql database with user and made migrations
* compile .po .mo for view/template/js
* local_settings.py, deploy_settings.py
* new git repository
* fabric for deploying and updating
* makefile for making message, run server, and other ...
********
Requirements
********
* vagrant
* virtualbox
* sh
********
Quickly start
********
Download `init.sh <https://gist.github.com/Arfey/a07ee02be72632a681c4392288114a20/>`_ and put it to the work dir.
For create new django-project you should typing code is below into terminal.
::

    $ sh init.sh name_project
