#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

BASE_DOMAIN=${BASE_DOMAIN:-example.com}

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}

for i in $(seq 1 $NODE_CNT); do
    eval "cfcli rm ns$i.ns.dns.${CLUSTER_ID}.${BASE_DOMAIN}"
done
eval "cfcli rm ${CLUSTER_ID}.${BASE_DOMAIN}"
