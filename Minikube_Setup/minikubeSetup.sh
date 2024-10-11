#!/bin/bash

# Script to install Minikube on Ubuntu

# Update the package list
echo "Updating package list..."
sudo apt-get update -y

# Install dependencies
echo "Installing required dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add Minikube's GPG key
echo "Adding Minikube's GPG key..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Verify the installation
echo "Verifying Minikube installation..."
minikube version

# Start Minikube
echo "Starting Minikube..."
minikube start

# Check the status of Minikube
echo "Checking Minikube status..."
minikube status

# Print instructions for further steps
echo "Minikube installation complete!"
echo "You can now interact with your Minikube cluster using the 'kubectl' command."
