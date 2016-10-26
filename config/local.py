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

USE_DEBUG_TOOLBAR = True

if USE_DEBUG_TOOLBAR:
    DEBUG_TOOLBAR_PATCH_SETTINGS = False

    INSTALLED_APPS += ['debug_toolbar']
    MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware']

    DEBUG_TOOLBAR_PANELS = [
        # 'debug_toolbar.panels.versions.VersionsPanel',
        'debug_toolbar.panels.timer.TimerPanel',
        # 'debug_toolbar.panels.settings.SettingsPanel',
        # 'debug_toolbar.panels.headers.HeadersPanel',
        # 'debug_toolbar.panels.request.RequestPanel',
        # 'debug_toolbar.panels.sql.SQLPanel',
        # 'debug_toolbar.panels.staticfiles.StaticFilesPanel',
        'debug_toolbar.panels.templates.TemplatesPanel',
        # 'debug_toolbar.panels.cache.CachePanel',
        # 'debug_toolbar.panels.signals.SignalsPanel',
        # 'debug_toolbar.panels.logging.LoggingPanel',
        # 'debug_toolbar.panels.redirects.RedirectsPanel',
    ]

    DEBUG_TOOLBAR_CONFIG = {"SHOW_TOOLBAR_CALLBACK": lambda x: True}

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '..')

STATICFILES_DIRS = [os.path.join(BASE_DIR, '..', 'static')]

# email

EMAIL_USE_TLS = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'ccoshera@gmail.com'
EMAIL_HOST_PASSWORD = 'CosheraCosheraCoshera'
EMAIL_PORT = 587

