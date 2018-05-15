#!/bin/bash

CLUSTER_ID=${CLUSTER_ID:-$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 8 | head -n 1)}
SCW_ORG=${SCW_ORG:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
SCW_TOKEN=${SCW_TOKEN:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
CF_API_KEY=${CF_API_KEY:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
CF_API_EMAIL=${CF_API_EMAIL:-user@example.com}
BASE_DOMAIN=${BASE_DOMAIN:-example.com}

### delete
docker run -it \
-e "SCW_ORG=${SCW_ORG}" \
-e "SCW_TOKEN=${SCW_TOKEN}" \
-e "CF_API_KEY=${CF_API_KEY}" \
-e "CF_API_EMAIL=${CF_API_EMAIL}" \
-e "BASE_DOMAIN=${BASE_DOMAIN}" \
capsulecloud/kube-factory ./scripts/delete.sh $CLUSTER_ID