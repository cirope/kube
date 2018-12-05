#!/usr/bin/env bash

# Taken from: https://github.com/helm/helm/blob/master/docs/tiller_ssl.md

set -eu

while getopts ":n:d:c:s:" opt; do
  case $opt in
    n)  NAME="$OPTARG"                                             ;;
    d)  DAYS="$OPTARG"                                             ;;
    c)  CA_SUBJ="$OPTARG"                                          ;;
    s)  SUBJ="$OPTARG"                                             ;;
    :)  echo "Option -$OPTARG requires an argument." >&2 && exit 1 ;;
    \?) echo "Invalid option -$OPTARG"               >&2 && exit 1 ;;
  esac
done

NAME=${NAME:-tiller}
DAYS=${DAYS:-3650}
CA_SUBJ=${CA_SUBJ:-"/C=AR/ST=Mendoza/L=Godoy Cruz/O=Cirope S.A./OU=DevOps/CN=$NAME"}
SUBJ=${SUBJ:-"/C=AR/ST=Mendoza/L=Godoy Cruz/O=Cirope S.A./OU=DevOps/CN=$NAME-server"}
DIR=$(cd "$( dirname "$0")" && pwd)/certs

mkdir -p $DIR

# CA
if [ ! -f $DIR/ca.key.pem ]; then
  openssl genrsa -out $DIR/ca.key.pem 4096
  openssl req -new -x509 -sha256 \
    -key $DIR/ca.key.pem         \
    -days $(($DAYS * 2))         \
    -out $DIR/ca.cert.pem        \
    -subj "$CA_SUBJ"             \
    -extensions v3_ca
else
  echo "CA already exists!"
fi

if [ ! -f $DIR/$NAME.key.pem ]; then
  # Key
  openssl genrsa -out $DIR/$NAME.key.pem 4096

  # CSR
  openssl req -new -sha256  \
    -key $DIR/$NAME.key.pem \
    -out $DIR/$NAME.csr.pem \
    -subj "$SUBJ"

  # Signature
  openssl x509 -req          \
    -CA $DIR/ca.cert.pem     \
    -CAkey $DIR/ca.key.pem   \
    -CAcreateserial          \
    -in $DIR/$NAME.csr.pem   \
    -out $DIR/$NAME.cert.pem \
    -days $DAYS
else
  echo "Client cert for $NAME already exists!"
fi
