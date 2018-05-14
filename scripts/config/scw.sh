#!/bin/bash

CDIR=$(cd `dirname "$0"` && pwd)
cd "$CDIR"

SCW_ORG=${SCW_ORG:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
SCW_TOKEN=${SCW_TOKEN:-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
SCW_VERSION=`scw version | awk 'NR==1{print $3}'`

cat <<EOL > ~/.scwrc
{"organization":"$SCW_ORG","token":"$SCW_TOKEN","version":"$SCW_VERSION"}
EOL

chmod 600 ~/.scwrc