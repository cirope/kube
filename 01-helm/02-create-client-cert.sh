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

$DIR/certs/create-client-cert.sh -n $NAME
$DIR/certs/install-client-cert.sh -n $NAME
