#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}
NODE_CNT=${NODE_CNT:-3}
REGION=${REGION:-par1}

echo 'Wait until nodes running'
while :
do
  statuses=`scw --region=$REGION ps -a -f name=$CLUSTER_ID- | awk 'NR>1{print $6}'`
  result=`echo $statuses | awk '{if ($1 == "running" && $2 == "running" && $3 == "running") result="OK"; else result="NG"; print result;}'`
  if [ $(eval "echo ${result} | grep -e 'OK'") ]; then
    echo "complete."
    break    
  fi
  sleep 2s;
done

