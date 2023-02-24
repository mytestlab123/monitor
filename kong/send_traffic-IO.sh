#!/bin/bash

while true;
do
 curl https://backend-genesis2.dev.interopera.co/
 curl https://chain-service.dev.interopera.co/
 curl https://asset-service.dev.interopera.co/
 curl https://chain-api.dev.interopera.co/
 curl https://chain-rpc.dev.interopera.co/
 curl https://vault-api.dev.interopera.co/
 sleep 0.01
done