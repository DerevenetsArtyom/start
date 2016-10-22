from fabric.api import *
from fabric.contrib.console import confirm

def init():
	name = raw_input('Type name of project: ')
	local('git clone https://github.com/Arfey/start.git %s' % name)
	local('cd %s && rm -rf .git'  % name)
