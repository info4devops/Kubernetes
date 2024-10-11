#!/bin/bash

# Script to install kubectl on Ubuntu

# Update the package list
echo "Updating package list..."
sudo apt-get update -y

# Install curl if not already installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    sudo apt-get install -y curl
fi

# Download the latest release of kubectl
echo "Downloading kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make the kubectl binary executable
echo "Making kubectl executable..."
chmod +x kubectl

# Move the binary to a directory in your PATH
echo "Moving kubectl to /usr/local/bin..."
sudo mv kubectl /usr/local/bin/

# Verify the installation
echo "Verifying kubectl installation..."
kubectl version --client

# Print instructions for further steps
echo "kubectl installation complete!"
echo "You can now use kubectl to interact with your Kubernetes clusters."
