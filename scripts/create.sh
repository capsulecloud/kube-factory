#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
# CLUSTER_ID=${CLUSTER_ID:-2wf0ps1s}

eval "SCW_ORG=${SCW_ORG} SCW_TOKEN=${SCW_TOKEN} ./config/scw.sh"
eval "CF_API_KEY=${CF_API_KEY} CF_API_EMAIL=${CF_API_EMAIL} BASE_DOMAIN=${BASE_DOMAIN} ./config/cfcli.sh"

echo "CLUSTER_ID is ${CLUSTER_ID}"
eval "CLUSTER_ID=${CLUSTER_ID} ./node/start.sh"
eval "CLUSTER_ID=${CLUSTER_ID} ./node/status.sh"
eval "CLUSTER_ID=${CLUSTER_ID} ./dns/create.sh"
eval "CLUSTER_ID=${CLUSTER_ID} BASE_DOMAIN=${BASE_DOMAIN} LONGHORN_CLIENT_ID=${LONGHORN_CLIENT_ID} LONGHORN_CLIENT_SECRET=${LONGHORN_CLIENT_SECRET} ./cluster/build.sh"
