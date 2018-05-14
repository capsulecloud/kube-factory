#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}
REGION=${REGION:-par1}
IMAGE=${IMAGE:-3dcbd786}

for i in $(seq 1 $NODE_CNT); do
  scw --region=$REGION start $(scw --region=$REGION create --name="$CLUSTER_ID-n$i" $IMAGE);
done
