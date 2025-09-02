#!/bin/bash
# ===============================================
# Minikube + Docker Installation Script (Ubuntu)
# ===============================================
# Author: Jagadish V
# Description: This script installs Minikube with Docker as the default driver.
# Tested on: Ubuntu 20.04 / 22.04 (x86_64)
# ===============================================

set -e  # Exit on error

echo "Starting Minikube + Docker installation..."

# -----------------------------
# 1. System Update
# -----------------------------
echo "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# -----------------------------
# 2. Install Minikube
# -----------------------------
echo "Installing Minikube..."
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
echo "Minikube installed successfully!"

# -----------------------------
# 3. Install Docker
# -----------------------------
echo "Installing Docker..."

# Install dependencies
sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

# Add Docker’s official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Set up repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"${UBUNTU_CODENAME:-$VERSION_CODENAME}\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
sudo docker run hello-world || true
echo "Docker installed successfully!"

# -----------------------------
# 4. Manage Docker as Non-Root User
# -----------------------------
echo "👤 Configuring Docker for non-root usage..."
sudo groupadd docker || true
sudo usermod -aG docker $USER
echo "Please log out and log back in (or restart your VM) for group changes to take effect."

# -----------------------------
# 5. Enable Docker on Boot
# -----------------------------
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# -----------------------------
# 6. Configure Minikube to use Docker driver
# -----------------------------
echo "Configuring Minikube to use Docker driver..."
minikube config set driver docker

echo "Installation complete!"
echo "Next steps:"
echo "   1. Log out and log back in (or restart your VM)."
echo "   2. Start Minikube with:  minikube start"
