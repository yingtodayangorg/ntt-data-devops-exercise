import os
import jwt
import time
import uuid
import pytest
from app import create_app


@pytest.fixture()
def client():
    os.environ['API_KEY_VALUE'] = '2f5ae96c-b558-4c7b-a590-a501ae1c3f6c'
    os.environ['JWT_SECRET'] = 'secret-key-for-devops-api-ntt-data'
    app = create_app()
    app.testing = True
    return app.test_client()


def _jwt(secret: str, ttl=60):
    now = int(time.time())
    payload = {'jti': str(uuid.uuid4()), 'iat': now, 'exp': now + ttl}
    return jwt.encode(payload, secret, algorithm='HS256')


def test_health(client):
    r = client.get('/healthcheck')
    assert r.status_code == 200


def test_devops_ok(client):
    token = _jwt('secret-key-for-devops-api-ntt-data')
    headers = {
        'X-Parse-REST-API-Key': '2f5ae96c-b558-4c7b-a590-a501ae1c3f6c',
        'X-JWT-KWY': token,
        'Content-Type': 'application/json'
    }
    body = {
        'message': 'This is a test',
        'to': 'Juan Perez',
        'from': 'Rita Asturia',
        'timeToLifeSec': 45
    }
    r = client.post('/DevOps', json=body, headers=headers)
    assert r.status_code == 200
    assert r.get_json()['message'] == 'Hello Juan Perez your message will be sent'


def test_method_not_allowed(client):
    token = _jwt('secret-key-for-devops-api-ntt-data')
    headers = {'X-Parse-REST-API-Key': '2f5ae96c-b558-4c7b-a590-a501ae1c3f6c', 'X-JWT-KWY': token}
    r = client.get('/DevOps', headers=headers)
    assert r.status_code == 405
    assert r.get_json()['error'] == 'ERROR'


def test_replay_protection(client):
    token = _jwt('secret-key-for-devops-api-ntt-data')
    headers = {
        'X-Parse-REST-API-Key': '2f5ae96c-b558-4c7b-a590-a501ae1c3f6c',
        'X-JWT-KWY': token,
        'Content-Type': 'application/json'
    }
    body = {'message': 'This is a test', 'to': 'Juan Perez',
            'from': 'Rita Asturia', 'timeToLifeSec': 45}
    r1 = client.post('/DevOps', json=body, headers=headers)
    assert r1.status_code == 200
    r2 = client.post('/DevOps', json=body, headers=headers)
    assert r2.status_code == 401
