#!/bin/bash

# Script to install kubectl on Ubuntu

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install curl if not already installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    sudo apt-get install -y curl
fi

# Download kubectl binary
echo "Downloading kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download kubectl checksum
echo "Downloading kubectl checksum..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Verify the checksum
echo "Verifying kubectl checksum..."
if echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check; then
    echo "Checksum verification successful."
else
    echo "Checksum verification failed. Exiting."
    exit 1
fi

# Install kubectl
echo "Installing kubectl..."
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Make kubectl executable
chmod +x /usr/local/bin/kubectl

# Create local bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Move kubectl to local bin
mv ./kubectl ~/.local/bin/kubectl

# Append ~/.local/bin to PATH if not already present
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "Added ~/.local/bin to PATH in ~/.bashrc."
fi

# Load the new PATH
source ~/.bashrc

# Verify the installation
echo "Verifying kubectl installation..."
kubectl version --client

echo "kubectl installation complete!"
