#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

BASE_DOMAIN=${BASE_DOMAIN:-example.com}

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}
REGION=${REGION:-par1}

array=()
for i in $(seq 1 $NODE_CNT); do
    ip=$(scw --region=$REGION inspect $(scw --region=$REGION ps -qa -f name=$CLUSTER_ID-n$i) | jq -r '.[] | "\(.public_ip.address)"';)
    array=("${array[@]}" $ip)
done

echo ${array[0]},${array[1]},${array[2]}

# HOST_USER=${HOST_USER:-root}
# SSH_KEY_PATH=${HOME}/.ssh/id_rsa
# RANCHER=true
# LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
# LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}

# docker run -it -d --name=$CLUSTER_ID \
# -v $CLUSTER_ID:/usr/local/src/kube-assembler \
# -v $CLUSTER_ID-certs:/etc/letsencrypt \
# -e "HOST_USER=${HOST_USER}" \
# -e "TARGET_HOSTS=${array[0]},${array[1]},${array[2]}" \
# -v ${SSH_KEY_PATH}:/root/.ssh/id_rsa \
# -e "BASE_DOMAIN=${CLUSTER_ID}.${BASE_DOMAIN}" \
# -e "RANCHER=${RANCHER}" \
# -e "LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID}" \
# -e "LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET}" \
# capsulecloud/kube-assembler

