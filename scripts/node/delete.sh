#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}
REGION=${REGION:-par1}

scw --region=$REGION rm -f $(scw --region=$REGION ps -q -f name=$CLUSTER_ID-);
