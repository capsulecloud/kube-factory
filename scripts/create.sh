#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CLUSTER_ID=$1

eval "SCW_ORG=${SCW_ORG} SCW_TOKEN=${SCW_TOKEN} ./config/scw.sh"
eval "CF_API_KEY=${CF_API_KEY} CF_API_EMAIL=${CF_API_EMAIL} BASE_DOMAIN=${BASE_DOMAIN} ./config/cfcli.sh"

start=`CLUSTER_ID=${CLUSTER_ID} ./node/start.sh`
status=`CLUSTER_ID=${CLUSTER_ID} ./node/status.sh`
create=`CLUSTER_ID=${CLUSTER_ID} ./dns/create.sh`
eval "CLUSTER_ID=${CLUSTER_ID} BASE_DOMAIN=${BASE_DOMAIN} ./node/info.sh"
