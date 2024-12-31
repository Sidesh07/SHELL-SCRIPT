#!/bin/bash

# Function to install and enable Docker on Linux (Ubuntu/Debian)
install_and_enable_docker() {
    echo "Installing Docker on Linux (Ubuntu/Debian)..."

    # Update package list
    sudo apt-get update -y

    # Install Docker
    sudo apt-get install -y docker.io

    # Start Docker service
    sudo systemctl start docker

    # Enable Docker to start on boot
    sudo systemctl enable docker

    echo "Docker installed and started successfully on Linux."
}

# Call the function
install_and_enable_docker
