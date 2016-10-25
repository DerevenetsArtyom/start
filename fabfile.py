from fabric.api import *
from fabric.contrib.console import confirm

import os

folder_path = os.path.dirname(__file__)
path, project = os.path.split(folder_path)

def init():
	print(project)


def create_local_file():
	local('rm %s/%s/%s/%s/settings/local_settings.py' % (path, project, project, project))
	local('ln -s %s/%s/config/local.py %s/%s/%s/%s/settings/local_settings.py' % (path, project, path, project, project, project))

def create_prodaction_file():
	pass
