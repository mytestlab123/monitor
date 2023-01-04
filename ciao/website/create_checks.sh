#/bin/bash

for file in *.json
do
    echo $file
    curl -s -X POST -u admin:admin localhost:8090/checks.json \
  -H "Content-Type:  application/json" \
  --data-binary "@$file" | jq .
done
