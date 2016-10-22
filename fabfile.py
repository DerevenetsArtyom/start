from fabric.api import *
from fabric.contrib.console import confirm

import os

project = os.path.dirname(__file__)

def init():
	print(project)
