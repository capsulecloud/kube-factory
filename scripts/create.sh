#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

echo "Start to lauch nodes and configure DNS"

CLUSTER_ID=${CLUSTER_ID:-$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}
SCW_ORG=${SCW_ORG:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
SCW_TOKEN=${SCW_TOKEN:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
CF_API_KEY=${CF_API_KEY:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
CF_API_EMAIL=${CF_API_EMAIL:-user@example.com}
BASE_DOMAIN=${BASE_DOMAIN:-example.com}

eval "SCW_ORG=${SCW_ORG} SCW_TOKEN=${SCW_TOKEN} ./config/scw.sh"
eval "CF_API_KEY=${CF_API_KEY} CF_API_EMAIL=${CF_API_EMAIL} BASE_DOMAIN=${BASE_DOMAIN} ./config/cfcli.sh"

eval "CLUSTER_ID=${CLUSTER_ID} ./node/start.sh"
eval "CLUSTER_ID=${CLUSTER_ID} ./node/status.sh"
eval "CLUSTER_ID=${CLUSTER_ID} ./dns/create.sh"
info=`CLUSTER_ID=${CLUSTER_ID} BASE_DOMAIN=${BASE_DOMAIN} ./node/info.sh`

echo $info
domain=$(echo $info | jq -r .domain)
node1=$(echo $info | jq -r .node1)
node2=$(echo $info | jq -r .node2)
node3=$(echo $info | jq -r .node3)

echo "Start to deploy kubernetes"
TARGET_HOSTS=$node1,$node2,$node3
HOST_USER=${HOST_USER:-root}
SSH_KEY_PATH=${SSH_KEY_PATH:-~/.ssh/id_rsa}

BASE_DOMAIN=$domain \
RANCHER=true \
LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx} \
LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx} \
/usr/local/src/kube-assembler/assemble.sh
