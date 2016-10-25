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

LANGUAGES = [
  ('en', _('English')),
]


STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '..')

STATICFILES_DIRS = [os.path.join(BASE_DIR, '..', 'static')]

REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 10
}

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(BASE_DIR, '../', 'logs', '%s.log' % DB_NAME),
            'maxBytes': 1024 * 1024 * 10,
            'backupCount': 50,
            'formatter': 'verbose'
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
    },
    'loggers': {
        'django.request': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        }
    }
}

LOCALE_PATHS = [
    os.path.join(BASE_DIR, '', 'locale'),
]

# email

EMAIL_USE_TLS = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'ccoshera@gmail.com'
EMAIL_HOST_PASSWORD = 'CosheraCosheraCoshera'
EMAIL_PORT = 587

# CELERY SETTINGS
BROKER_URL = 'redis://localhost:6379/0'
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'


CELERY_QUEUES = (
    Queue('high', Exchange('high'), routing_key='high'),
    Queue('normal', Exchange('normal'), routing_key='normal'),
    Queue('low', Exchange('low'), routing_key='low'),
)

CELERY_DEFAULT_QUEUE = 'normal'
CELERY_DEFAULT_EXCHANGE = 'normal'
CELERY_DEFAULT_ROUTING_KEY = 'normal'

# CELERY_ROUTES = {
#     'coshera.tasks.send_messages': {'queue': 'normal'},
#     'coshera.tasks.notify_about_mark': {'queue': 'normal'},
#     'coshera.tasks.notify_about_final_mark': {'queue': 'normal'},
# }
