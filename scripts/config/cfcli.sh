#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

CF_API_KEY=${CF_API_KEY:-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}
CF_API_EMAIL=${CF_API_EMAIL:-user@example.com}
BASE_DOMAIN=${BASE_DOMAIN:-example.com}

cat <<EOL > ~/.cfcli.yml
defaults:
    token: $CF_API_KEY
    email: $CF_API_EMAIL
    domain: $BASE_DOMAIN
EOL

chmod 600 ~/.cfcli.yml