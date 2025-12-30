#!/bin/bash

set -e

# Always run relative to this script’s location
cd "$(dirname "$0")"

echo "Stopping all running Docker containers..."
docker stop $(docker ps -a -q)

echo "Deploying lbt-auth-api..."
cd ../../lbt-auth-api
git pull origin master
docker compose up -d --build

echo "Deploying lbt-gateway..."
cd ../lbt-gateway
git pull origin master
docker compose up -d --build

echo "Deploying lbt-reverse-proxy..."
cd ../lbt-reverse-proxy
git pull origin master
docker compose up -d --build

echo "Done."
