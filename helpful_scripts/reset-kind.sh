#!/bin/bash

set -e

CLUSTER_NAME="dev-cluster"
CONFIG_FILE="kind-config.yaml"
KUBECONFIG_FILE="$HOME/.kube/config"

# 1. Delete existing cluster (if exists)
echo "Deleting existing kind cluster (if any)..."
kubectl config delete-context kind-$CLUSTER_NAME 2>/dev/null || true
kind delete cluster --name "$CLUSTER_NAME" || true

# 2. Recreate cluster with correct config
echo "Creating new Kind cluster..."
kind create cluster --name "$CLUSTER_NAME" --config "$CONFIG_FILE"

# 3. Set server address to host.docker.internal in kubeconfig (for Jenkins container access)
echo "Patching kubeconfig to use host.docker.internal..."
kubectl config set-cluster kind-$CLUSTER_NAME \
  --server="https://host.docker.internal:43399"

# 4. Label the node for Ingress NGINX scheduling
echo "Labeling node for ingress-nginx..."
kubectl label node "$CLUSTER_NAME-control-plane" ingress-ready=true --overwrite

# 5. Install Ingress NGINX controller (for Kind)
echo "Deploying ingress-nginx controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/kind/deploy.yaml

# 6. Wait for the ingress-nginx controller to become ready
echo "Waiting for ingress-nginx controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# 7. Redeploy application and ingress
echo "Applying application Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

# Done
echo "Kind cluster is ready and app is deployed."
echo "Visit: http://mathlinux.local/add?a=5&b=5 (ensure /etc/hosts is updated)"
