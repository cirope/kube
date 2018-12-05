#!/usr/bin/env bash

# Taken from: https://github.com/helm/helm/blob/master/docs/tiller_ssl.md

set -eu

while getopts ":n:d:s:" opt; do
  case $opt in
    n)  NAME="$OPTARG"                                             ;;
    d)  DAYS="$OPTARG"                                             ;;
    s)  SUBJ="$OPTARG"                                             ;;
    :)  echo "Option -$OPTARG requires an argument." >&2 && exit 1 ;;
    \?) echo "Invalid option -$OPTARG"               >&2 && exit 1 ;;
  esac
done

NAME=${NAME:-helm}
DAYS=${DAYS:-3650}
SUBJ=${SUBJ:-"/C=AR/ST=Mendoza/L=Godoy Cruz/O=Cirope S.A./OU=DevOps/CN=$NAME"}
DIR=$(cd "$( dirname "$0")" && pwd)
CERTS_DIR=$DIR/client

mkdir -p $CERTS_DIR

if [ ! -f $CERTS_DIR/$NAME.key.pem ]; then
  # Key
  openssl genrsa -out $CERTS_DIR/$NAME.key.pem 4096

  # CSR
  openssl req -new -sha256        \
    -key $CERTS_DIR/$NAME.key.pem \
    -out $CERTS_DIR/$NAME.csr.pem \
    -subj "$SUBJ"

  # Signature
  openssl x509 -req                \
    -CA $DIR/ca.cert.pem           \
    -CAkey $DIR/ca.key.pem         \
    -CAcreateserial                \
    -in $CERTS_DIR/$NAME.csr.pem   \
    -out $CERTS_DIR/$NAME.cert.pem \
    -days $DAYS
else
  echo "Client cert for $NAME already exists!"
fi
