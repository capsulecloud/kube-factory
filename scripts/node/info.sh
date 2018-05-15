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

echo "{\"id\": \"$CLUSTER_ID\", \"domain\": \"$CLUSTER_ID.$BASE_DOMAIN\", \"node1\": \"${array[0]}\", \"node2\": \"${array[1]}\", \"node3\": \"${array[2]}\"}"
