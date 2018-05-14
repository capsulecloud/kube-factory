#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

BASE_DOMAIN=${BASE_DOMAIN:-example.com}

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}
REGION=${REGION:-par1}

for i in $(seq 1 $NODE_CNT); do
    eval "cfcli add -t NS ${CLUSTER_ID}.${BASE_DOMAIN} ns$i.ns.dns.${CLUSTER_ID}.${BASE_DOMAIN}"
    ip=$(scw --region=$REGION inspect $(scw --region=$REGION ps -qa -f name=$CLUSTER_ID-n$i) | jq -r '.[] | "\(.public_ip.address)"';)
    eval "cfcli add -t A ns$i.ns.dns.${CLUSTER_ID}.${BASE_DOMAIN} $ip"
done
