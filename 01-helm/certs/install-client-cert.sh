#!/usr/bin/env bash

set -eu

while getopts ":n:" opt; do
  case $opt in
    n)  NAME="$OPTARG"                                             ;;
    :)  echo "Option -$OPTARG requires an argument." >&2 && exit 1 ;;
    \?) echo "Invalid option -$OPTARG"               >&2 && exit 1 ;;
  esac
done

NAME=${NAME:-helm}
DIR=$(cd "$( dirname "$0")" && pwd)
CERTS_DIR=$DIR/client

if [ -f $CERTS_DIR/$NAME.key.pem ]; then
  cp -i $DIR/ca.cert.pem $(helm home)/ca.pem
  cp -i $CERTS_DIR/$NAME.cert.pem $(helm home)/cert.pem
  cp -i $CERTS_DIR/$NAME.key.pem $(helm home)/key.pem
else
  echo "Client cert for $NAME do not exists!"
fi
