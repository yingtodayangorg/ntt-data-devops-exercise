import os

class Config:
    API_KEY_HEADER = os.getenv('API_KEY_HEADER', 'X-Parse-REST-API-Key')
    API_KEY_VALUE = os.getenv('API_KEY_VALUE', '2f5ae96c-b558-4c7b-a590-a501ae1c3f6c')

    JWT_HEADER = os.getenv('JWT_HEADER', 'X-JWT-KWY')
    JWT_ALG = os.getenv('JWT_ALG', 'HS256')
    JWT_SECRET = os.getenv('JWT_SECRET', 'secret-key-for-devops-api-ntt-data')

    JWT_REPLAY_WINDOW = int(os.getenv('JWT_REPLAY_WINDOW', '60'))
