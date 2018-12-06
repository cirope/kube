#!/usr/bin/env bash

helm install stable/prometheus --tls --name prometheus --namespace monitoring
