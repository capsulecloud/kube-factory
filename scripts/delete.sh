#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=$1

eval "SCW_ORG=${SCW_ORG} SCW_TOKEN=${SCW_TOKEN} ./config/scw.sh"
eval "CF_API_KEY=${CF_API_KEY} CF_API_EMAIL=${CF_API_EMAIL} BASE_DOMAIN=${BASE_DOMAIN} ./config/cfcli.sh"

echo "CLUSTER_ID is ${CLUSTER_ID}"
eval "CLUSTER_ID=${CLUSTER_ID} ./dns/delete.sh"
eval "CLUSTER_ID=${CLUSTER_ID} ./node/delete.sh"