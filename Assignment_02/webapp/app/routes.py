from flask import Blueprint, request, make_response
from .models import HealthCheck
from . import db

healthz = Blueprint('healthz', __name__)

@healthz.route('/healthz', methods=['GET'])
def health_check():
    if request.data:
        return make_response('', 400, {'Cache-Control': 'no-cache'})

    try:
        check = HealthCheck()
        db.session.add(check)
        db.session.commit()
        return make_response('', 200, {'Cache-Control': 'no-cache'})
    except Exception:
        return make_response('', 503, {'Cache-Control': 'no-cache'})

@healthz.route('/healthz', methods=['POST', 'PUT', 'DELETE', 'PATCH'])
def method_not_allowed():
    return make_response('', 405, {'Cache-Control': 'no-cache'})
