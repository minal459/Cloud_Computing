from . import db
from datetime import datetime

class HealthCheck(db.Model):
    __tablename__ = 'health_check'

    id = db.Column(db.Integer, primary_key=True)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
