#!/bin/bash

SSH_KEY=$(cat ~/.ssh/id_rsa_insylva_docker)
# SSH_KEY=$(cat ./id_rsa)
SSH_KEY_PASSPHRASE="$(cat ~/.ssh/id_rsa_insylva_docker.pub)"
# --build-arg SSH_KEY_PASSPHRASE="$SSH_KEY_PASSPHRASE"
docker build --build-arg SSH_KEY="$SSH_KEY" --build-arg SSH_KEY_PASSPHRASE="$SSH_KEY_PASSPHRASE" --tag in_sylva_gatekeeper .
# docker build -t in_sylva_keycloak --build-arg SSH_KEY="$(cat ~/.ssh/id_rsa_insylva_docker)" --build-arg SSH_KEY_PASSPHRASE="$(cat ~/.ssh/id_rsa_insylva_docker.pub)" --build-arg KNOWN_HOSTS="$(cat ~/.ssh/known_hosts)" --squash --net=host . 
