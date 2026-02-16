#!/usr/bin/env bash
# KiraKota k3s Bootstrap - Runs inside WSL2 Ubuntu
# Sets up a single-node k3s cluster with web UI
set -euo pipefail

CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; NC='\033[0m'
info() { echo -e "${GREEN}[kk]${NC} $*"; }
err()  { echo -e "${RED}[kk]${NC} $*" >&2; }

K3S_VERSION="v1.31.4+k3s1"

# --- Step 1: Install k3s ---
info "Installing k3s ${K3S_VERSION}..."
if command -v k3s &>/dev/null; then
    info "k3s already installed: $(k3s --version)"
else
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="${K3S_VERSION}" sh -s - \
        --write-kubeconfig-mode 644 \
        --disable traefik \
        --disable servicelb \
        --data-dir /var/lib/rancher/k3s
fi

# --- Step 2: Wait for k3s to be ready ---
info "Waiting for k3s to be ready..."
timeout 120 bash -c 'until k3s kubectl get nodes 2>/dev/null | grep -q " Ready"; do sleep 2; done'
info "k3s is ready!"
k3s kubectl get nodes

# --- Step 3: Create namespaces ---
info "Creating namespaces..."
k3s kubectl create namespace kk-dev 2>/dev/null || true
k3s kubectl create namespace kk-games 2>/dev/null || true
k3s kubectl create namespace kk-services 2>/dev/null || true

# --- Step 4: Install Helm (if not present) ---
if ! command -v helm &>/dev/null; then
    info "Installing Helm..."
    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

# --- Step 5: Install Kubernetes Dashboard ---
info "Installing Kubernetes Dashboard..."
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/ 2>/dev/null || true
helm repo update
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard \
    --namespace kk-services \
    --set service.type=NodePort \
    --set service.nodePort=30443 2>/dev/null || info "Dashboard install skipped (may already exist)"

# --- Step 6: Print summary ---
echo ""
info "=============================="
info "  KiraKota Cluster Ready!"
info "=============================="
echo ""
info "Namespaces:"
k3s kubectl get namespaces | grep kk-
echo ""
info "Nodes:"
k3s kubectl get nodes -o wide
echo ""
WSL_IP=$(hostname -I | awk '{print $1}')
info "Dashboard: https://${WSL_IP}:30443"
echo ""
info "Next steps:"
echo "  kk pod ps          List pods"
echo "  kk pod create      Create a blank pod"
echo "  kk pod attach 1    Shell into pod #1"
