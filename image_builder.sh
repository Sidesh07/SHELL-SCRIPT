#!/bin/bash

# Define variables
DOCKERFILE_DIRECTORY="$HOME/CODE/backend-nest-pro"  # Directory containing the Dockerfile
IMAGE_NAME="nest"  # Name of the Docker image
CONTAINER_NAME="nest_con"  # Name of the Docker container

# Function to build Docker image
build_docker_image() {
    echo "Building Docker image from directory '$DOCKERFILE_DIRECTORY'..."

    # Navigate to the directory containing the Dockerfile
    cd "$DOCKERFILE_DIRECTORY" || { echo "Directory not found: $DOCKERFILE_DIRECTORY"; exit 1; }

    # Build the Docker image
    sudo docker build -t "$IMAGE_NAME" .
    if [[ $? -ne 0 ]]; then
        echo "Error: Docker image build failed."
        exit 1
    fi

    echo "Docker image '$IMAGE_NAME' built successfully."
}

# Function to run Docker container
run_docker_container() {
    echo "Running Docker container from image '$IMAGE_NAME'..."

    # Check if the container already exists
    if sudo docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q "^$CONTAINER_NAME$"; then
        echo "Container '$CONTAINER_NAME' already exists. Removing it..."
        # Stop and remove the existing container
        sudo docker rm -f "$CONTAINER_NAME"
        echo "Container '$CONTAINER_NAME' removed."
    fi

    # Run the Docker container
    sudo docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to run Docker container."
        exit 1
    fi

    echo "Docker container '$CONTAINER_NAME' is running."
}

# Main script execution
build_docker_image
run_docker_container
