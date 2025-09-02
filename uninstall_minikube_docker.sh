#!/bin/bash
# =================================================
# Uninstall Minikube + Docker (Ubuntu)
# =================================================
# Author: Jagadish V
# Description: This script removes Minikube and Docker completely.
# =================================================

set -e  # Exit on error

echo "Starting cleanup: Removing Minikube + Docker..."

# -----------------------------
# 1. Stop and Delete Minikube
# -----------------------------
if command -v minikube >/dev/null 2>&1; then
    echo "Stopping Minikube..."
    minikube stop || true
    echo "Deleting Minikube cluster..."
    minikube delete || true
    echo "Removing Minikube binary..."
    sudo rm -f /usr/local/bin/minikube
    rm -rf ~/.minikube ~/.kube
else
    echo "Minikube not found, skipping..."
fi

# -----------------------------
# 2. Remove Docker Packages
# -----------------------------
echo "Removing Docker packages..."
sudo systemctl stop docker || true
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras || true

# -----------------------------
# 3. Remove Docker Dependencies
# -----------------------------
echo "Removing unused dependencies..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# -----------------------------
# 4. Delete Docker Files
# -----------------------------
echo "Removing Docker files..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /etc/apt/sources.list.d/docker.list
sudo rm -rf /etc/apt/keyrings/docker.asc

# -----------------------------
# 5. Remove User Group (optional)
# -----------------------------
if getent group docker >/dev/null; then
    echo "Removing docker group..."
    sudo groupdel docker || true
fi

echo "Uninstallation complete!"
echo "Recommended: run 'sudo reboot' to clear any leftover processes."
