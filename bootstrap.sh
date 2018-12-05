#!/usr/bin/env bash

set -eu

NAME=${1:-$USER}

printf "\n\n\nInstalling helm...\n\n\n\n"

01-helm/01-create-tiller-cert.sh
01-helm/02-create-client-cert.sh -n $NAME
01-helm/03-helm-init.sh

printf "\n\n\nInstalling Prometheus and Grafana...\n\n\n\n"

02-monitoring/01-prometheus-install.helm.sh
02-monitoring/02-grafana-install.helm.sh

printf "\n\n\nInstalling Ingress Nginx and Cert manager...\n\n\n\n"

03-ingress/01-nginx-ingress-controller-install.helm.sh
03-ingress/02-cert-manager-install.helm.sh
03-ingress/03-cert-manager-create-cluster-issuer.sh

printf "\n\n\nDone!\n"
