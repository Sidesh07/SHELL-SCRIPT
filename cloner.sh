#!/bin/bash

# Function to clone a repository and checkout a specific branch
clone_repo_with_branch() {
    local repo_url=$1
    local branch_name=$2

    echo "Cloning the repository from $repo_url and checking out branch '$branch_name'..."

    # Clone the repository and checkout the specific branch
    git clone -b "$branch_name" "$repo_url"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to clone repository or checkout branch '$branch_name'."
        exit 1
    fi

    echo "Repository cloned and switched to branch '$branch_name'."
}

# Example usage
REPO_URL="git@gitlab.rapidinnovation.tech:root/backend-nest-pro.git"
BRANCH_NAME="main"  # Change to the desired branch name

# Call the function
clone_repo_with_branch "$REPO_URL" "$BRANCH_NAME"
