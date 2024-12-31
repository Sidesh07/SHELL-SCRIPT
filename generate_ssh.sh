#!/bin/bash

# Define the path to the SSH key
SSH_KEY_PATH="$HOME/.ssh/id_rsa"
PUBLIC_KEY_PATH="$SSH_KEY_PATH.pub"

# Function to generate SSH key
generate_ssh_key() {
    # Check if the SSH key already exists
    if [[ ! -f "$SSH_KEY_PATH" ]]; then
        echo "SSH key not found. Generating a new one..."
        # Generate a new SSH key
        ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -N ""
        echo "SSH key generated and saved to $SSH_KEY_PATH"
    else
        echo "SSH key already exists. Displaying the public key..."
        # Display the public key if it exists
        cat "$PUBLIC_KEY_PATH"
    fi
}

# Run the function
generate_ssh_key
