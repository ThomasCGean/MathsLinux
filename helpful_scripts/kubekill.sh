#!/bin/bash

kubectl config delete-context kind-dev-cluster || echo "Could not delete kubernetes config file"
kind delete cluster --name "dev-cluster" || echo "Could not kill dev-cluster"