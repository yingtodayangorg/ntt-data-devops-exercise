import os
import jwt
import uuid
import time
import base64
import argparse

def main():
    parser = argparse.ArgumentParser(description='Generar JWT único para NTT DevOps API')
    parser.add_argument('--secret', help='Secret codificado en Base64 (si no se pasa, usa JWT_SECRET o valor por defecto)', default=os.getenv('JWT_SECRET_B64', None))
    parser.add_argument('--ttl', type=int, help='Tiempo de vida en segundos (default: 60)', default=60)
    args = parser.parse_args()

    if args.secret:
        try:
            secret_bytes = base64.b64decode(args.secret)
            secret = secret_bytes.decode('utf-8')
        except Exception:
            print('❌ Error: el secreto Base64 no es válido.')
            return
    else:
        default_secret = 'dev-secret-key-for-ntt-data-devops-api'
        secret = default_secret
        args.secret = base64.b64encode(default_secret.encode()).decode()

    now = int(time.time())
    payload = {'jti': str(uuid.uuid4()), 'iat': now, 'exp': now + args.ttl}
    token = jwt.encode(payload, secret, algorithm='HS256')

    print('\n🔐 JWT generado correctamente\n')
    print(f'Base64 Secret: {args.secret}')
    print(f'JWT: {token}\n')
    print('📋 Usa este JWT en tu cURL con el header:')
    print('   -H "X-JWT-KWY: <token>"')

if __name__ == '__main__':
    main()
