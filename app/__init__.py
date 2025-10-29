from flask import Flask
from .config import Config
from .auth import require_api_key_and_jwt

def create_app() -> Flask:
    app = Flask(__name__)
    app.config.from_object(Config())

    @app.route('/healthcheck', methods=['GET'])
    def healthcheck():
        return {'status': 'ok'}, 200

    @app.route('/DevOps', methods=['POST', 'GET', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'])
    @require_api_key_and_jwt
    def devops():
        from flask import request, jsonify
        if request.method != 'POST':
            return jsonify({'error': 'ERROR'}), 405

        payload = request.get_json(silent=True) or {}
        from .schemas import MessageIn
        try:
            msg = MessageIn(**payload)
        except Exception as e:
            return jsonify({'error': 'Bad Request', 'detail': str(e)}), 400

        return jsonify({'message': f'Hello {msg.to} your message will be sent'}), 200

    return app
