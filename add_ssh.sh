#!/bin/bash

# Variables
GITLAB_API_URL=add your key
GITLAB_API_TOKEN=add your key
SSH_KEY= add your key
SSH_KEY_TITLE="My SSH Key"

# Function to list SSH keys
list_ssh_keys() {
    curl -s --header "Authorization: Bearer $GITLAB_API_TOKEN" \
         --header "Content-Type: application/json" \
         "$GITLAB_API_URL/user/keys"
}

# Function to delete an SSH key
delete_ssh_key() {
    local key_id=$1
    curl -s -X DELETE --header "Authorization: Bearer $GITLAB_API_TOKEN" \
         --header "Content-Type: application/json" \
         "$GITLAB_API_URL/user/keys/$key_id"
}

# Function to add an SSH key
add_ssh_key() {
    local ssh_key=$1
    local title=$2
    curl -s -X POST --header "Authorization: Bearer $GITLAB_API_TOKEN" \
         --header "Content-Type: application/json" \
         --data "{\"title\": \"$title\", \"key\": \"$ssh_key\"}" \
         "$GITLAB_API_URL/user/keys"
}

# Main script
echo "Fetching existing SSH keys..."
keys=$(list_ssh_keys)

if [[ -z "$keys" ]]; then
    echo "No existing SSH keys found."
else
    echo "Existing SSH keys:"
    echo "$keys" | jq -r '.[] | "ID: \(.id), Title: \(.title), Key: \(.key)"'
fi

# Check if the key exists
key_id=$(echo "$keys" | jq -r --arg SSH_KEY "$SSH_KEY" '.[] | select(.key == $SSH_KEY) | .id')

if [[ -n "$key_id" ]]; then
    echo "The SSH key already exists. Deleting it..."
    delete_ssh_key "$key_id"
    echo "Deleted existing SSH key with ID $key_id."
fi

echo "Adding the new SSH key..."
add_ssh_key "$SSH_KEY" "$SSH_KEY_TITLE"
echo "SSH key added successfully."
