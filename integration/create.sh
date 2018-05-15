#!/bin/bash

CLUSTER_ID=${CLUSTER_ID:-$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}
SCW_ORG=${SCW_ORG:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
SCW_TOKEN=${SCW_TOKEN:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
CF_API_KEY=${CF_API_KEY:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
CF_API_EMAIL=${CF_API_EMAIL:-user@example.com}
BASE_DOMAIN=${BASE_DOMAIN:-example.com}
SSH_KEY_PATH=${SSH_KEY_PATH:-~/.ssh/id_rsa}
LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

### create
echo "CLUSTER_ID is ${CLUSTER_ID}"
info=$(docker run -it \
-e "SCW_ORG=${SCW_ORG}" \
-e "SCW_TOKEN=${SCW_TOKEN}" \
-e "CF_API_KEY=${CF_API_KEY}" \
-e "CF_API_EMAIL=${CF_API_EMAIL}" \
-e "BASE_DOMAIN=${BASE_DOMAIN}" \
capsulecloud/kube-factory ./scripts/create.sh $CLUSTER_ID)

echo $info
domain=$(echo $info | jq -r .domain)
node1=$(echo $info | jq -r .node1)
node2=$(echo $info | jq -r .node2)
node3=$(echo $info | jq -r .node3)

echo "Start to deploy kubernetes"
docker run -it --name=$CLUSTER_ID \
-v $CLUSTER_ID:/usr/local/src/kube-assembler \
-v $CLUSTER_ID-certs:/etc/letsencrypt \
-e "TARGET_HOSTS=$node1,$node2,$node3" \
-v ${SSH_KEY_PATH}:/root/.ssh/id_rsa \
-e "BASE_DOMAIN=$domain" \
-e "RANCHER=true" \
-e "LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID}" \
-e "LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET}" \
capsulecloud/kube-assembler:0.2
