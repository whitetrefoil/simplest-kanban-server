# -*- coding: utf-8 -*-

DEBUG = True

MONGO_HOST = 'localhost'
MONGO_PORT = 27017
MONGO_DBNAME = 'simplest-kanban-eve'

URL_PREFIX = 'api'

RESOURCE_METHODS = ['GET', 'POST']
ITEM_METHODS = ['GET', 'PUT', 'DELETE']
BANDWIDTH_SAVER = False
PAGINATION = False

ALLOWED_FILTERS = []
PROJECTION = False

X_DOMAINS = '*'

tasks = {
    'schema': {
        'name': {
            'type': 'string',
            'minlength': 1,
            'required': True
        },
        'assignee': {
            'type': 'string',
            'nullable': True,
            'default': None,
            'data_relation': {
                'resource': 'assignees',
                'field': 'name'
            }
        },
        'status': {
            'type': 'string',
            'required': True,
            'data_relation': {
                'resource': 'statuses',
                'field': 'code'
            }
        },
        'milestone': {
            'type': 'objectid',
            'nullable': True,
            'default': None,
            'data_relation': {
                'resource': 'milestones',
                'field': '_id',
                'embeddable': True
            }
        }
    }
}

assignees = {
    'schema': {
        'name': {
            'type': 'string',
            'required': True,
            'unique': True
        }
    }
}

statuses = {
    'item_title': 'status',
    'schema': {
        'code': {
            'type': 'string',
            'required': True,
            'unique': True
        },
        'name': {
            'type': 'string',
            'required': True
        },
        'cssClass': {
            'type': 'string',
            'default': ''
        }
    }
}

milestones = {
    'schema': {
        'name': {
            'type': 'string',
            'required': True,
            'unique': True
        },
        'isClosed': {
            'type': 'boolean',
            'default': False
        }
    }
}

DOMAIN = {
    'tasks': tasks,
    'assignees': assignees,
    'statuses': statuses,
    'milestones': milestones
}
