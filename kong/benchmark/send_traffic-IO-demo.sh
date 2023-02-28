#!/bin/bash

while true;
do
 curl https://backend-genesis2.demo.interopera.co/
 curl https://chain-service.demo.interopera.co/
 curl https://asset-service.demo.interopera.co/
 curl https://chain-api.demo.interopera.co/
 curl https://chain-rpc.demo.interopera.co/
 curl https://vault-api.demo.interopera.co/
 sleep 0.01
done