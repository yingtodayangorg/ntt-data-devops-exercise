# NTT Data – DevOps Ejercicio práctico (Flask)

## Docker local
```bash
docker compose up --build -d
```

### JWT rápido (Python)
```python
python .\scripts\generate_jwt.py --secret "c2VjcmV0LWtleS1mb3ItZGV2b3BzLWFwaS1udHQtZGF0YQ==" 
```

### cURL
```bash
curl -X POST   -H "X-Parse-REST-API-Key: 2f5ae96c-b558-4c7b-a590-a501ae1c3f6c"   -H "X-JWT-KWY: ${JWT}"   -H "Content-Type: application/json"   -d '{ "message": "This is a test", "to": "Juan Perez", "from": "Rita Asturia", "timeToLifeSec": 45 }'   http://<HOST>/DevOps
```

## CI/CD
- PR: lint + tests + cobertura
- Build/Tag: build 
- main/tags: despliegue automático a k8s con Kong Ingress
