from django.utils.translation import ugettext_lazy as _
from kombu import Exchange, Queue
from .base import INSTALLED_APPS, MIDDLEWARE, BASE_DIR, DB_NAME

import os

LANGUAGE_CODE = 'en'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': DB_NAME,
        'USER': 'vagrant',
        'PASSWORD': 'vagrant',
    }
}

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '..')

STATICFILES_DIRS = [os.path.join(BASE_DIR, '..', 'static')]

# email

EMAIL_USE_TLS = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = '@gmail.com'
EMAIL_HOST_PASSWORD = ''
EMAIL_PORT = 587
