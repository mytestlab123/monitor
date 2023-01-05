# ciao

#### [ciao](https://github.com/brotandgames/ciao) checks HTTP(S) URL endpoints for a HTTP status code (or errors on the lower TCP stack) and sends a notification on status change via E-Mail or Webhooks.



### Docker run
```
docker run --name ciao -p 8090:3001 brotandgames/ciao
```

- `docker run --rm brotandgames/ciao rake time:zones`
- Full

```
docker run \
  --name ciao \
  -p 8090:3000 \
  -e SECRET_KEY_BASE="sensitive_secret_key_base" \
  -e SMTP_ADDRESS=smtp.yourhost.com \
  -e SMTP_EMAIL_FROM="ciao@yourhost.com" \
  -e SMTP_EMAIL_TO="you@yourhost.com" \
  -e SMTP_PORT=587 \
  -e SMTP_DOMAIN=smtp.yourhost.com \
  -e SMTP_AUTHENTICATION=plain \
  -e SMTP_ENABLE_STARTTLS_AUTO=true \
  -e SMTP_USERNAME=ciao \
  -e SMTP_PASSWORD="sensitive_password" \
  -v /opt/ciao/data:/app/db/sqlite \
  brotandgames/ciao
  ```

  - Via Docker-compose
```
version: "3"
services:
  ciao:
    image: brotandgames/ciao
    container_name: ciao
    ports:
      - '8090:3000'
    environment:
      - SECRET_KEY_BASE=sensitive_secret_key_base
      - SMTP_ADDRESS=smtp.yourhost.com
      - SMTP_EMAIL_FROM=ciao@yourhost.com
      - SMTP_EMAIL_TO=you@yourhost.com
      - SMTP_PORT=587
      - SMTP_AUTHENTICATION=plain
      - SMTP_DOMAIN=smtp.yourhost.com
      - SMTP_ENABLE_STARTTLS_AUTO=true
      - SMTP_USERNAME=ciao
      - SMTP_PASSWORD=sensitive_password
    volumes:
      - /opt/ciao/data:/app/db/sqlite/
```

- Pull and run
```
docker-compose pull
docker-compose up -d
```

- Create/Update a check
```
curl -X POST -H "Content-type: application/json" /checks.json \
  -d '{ "name": "brotandgames.com", "active": true, "url": "https://brotandgames.com", "cron": "* * * *"}'

```

- Recreate
```
curl -X POST -H "Content-type: application/json" localhost:8090/checks.json -d @checks.json

curl -i -X POST localhost:8090/checks.json \
  -H "Content-Type: application/json" \
  --data-binary "@checks.json"
```

- Create mutiple entries
```
for file in website/*
do
    echo $file
    curl -s -X POST -u admin:admin localhost:8090/checks.json \
  -H "Content-Type:  application/json" \
  --data-binary "@$file" | jq .
done

- Create one website entry
```
curl -s -X POST localhost:8090/checks.json \
  -H "Content-Type:  application/json" \
  --data-binary "@grafana.json" | jq .
```

- Backup & Restore
```
docker cp ciao:/app/db/sqlite/production.sqlite3 production.sqlite3.backup

docker cp production.sqlite3.backup ciao:/app/db/sqlite/production.sqlite3
docker restart ciao
```
