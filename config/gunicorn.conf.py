import multiprocessing
import os

os.environ['DJANGO_SETTINGS_MODULE'] = 'app.settings'

bind = '0.0.0.0:8833'
workers = multiprocessing.cpu_count() * 4 + 1
