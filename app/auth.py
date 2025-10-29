from functools import wraps
from flask import request, jsonify, current_app
import jwt
import time

_seen_jti = {}


def _prune_expired(now: float):
    to_del = [k for k, exp in _seen_jti.items() if exp <= now]
    for k in to_del:
        _seen_jti.pop(k, None)


def require_api_key_and_jwt(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        cfg = current_app.config
        api_key = request.headers.get(cfg['API_KEY_HEADER'])
        if not api_key or api_key != cfg['API_KEY_VALUE']:
            return jsonify({'error': 'Unauthorized: invalid API key'}), 401

        token = request.headers.get(cfg['JWT_HEADER'])
        if not token:
            return jsonify({'error': 'Unauthorized: missing JWT'}), 401

        try:
            claims = jwt.decode(token, cfg['JWT_SECRET'], algorithms=[cfg['JWT_ALG']])
        except Exception as e:
            return jsonify({'error': 'Unauthorized: invalid JWT', 'detail': str(e)}), 401

        jti = str(claims.get('jti', ''))
        exp = int(claims.get('exp', 0))
        now = int(time.time())
        if not jti:
            return jsonify({'error': 'Unauthorized: JWT requires jti claim'}), 401
        if exp and now >= exp:
            return jsonify({'error': 'Unauthorized: JWT expired'}), 401

        window = int(cfg.get('JWT_REPLAY_WINDOW', 60))
        if window > 0:
            _prune_expired(now)
            if jti in _seen_jti:
                return jsonify({'error': 'Unauthorized: JWT already used'}), 401
            ttl = min(exp or now + window, now + window)
            _seen_jti[jti] = float(ttl)

        return fn(*args, **kwargs)
    return wrapper
