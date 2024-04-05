#!/bin/bash

# Define the base path for installation
INSTALL_PATH="/opt/SSH-bible-verse"
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse"

# Install jq if not already installed
echo "Checking if jq is installed..."
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing..."
    sudo apt-get install jq || { echo "Failed to install jq."; exit 1; }
else
    echo "jq is already installed."
fi

# Check if the installation path exists
if [ -d "$INSTALL_PATH" ]; then
    echo "Updating the repository at $INSTALL_PATH..."
    cd "$INSTALL_PATH" || { echo "Failed to change directory to $INSTALL_PATH"; exit 1; }
    git pull origin master || { echo "Failed to update the repository."; exit 1; }
else
    # Clone the repository if it doesn't exist
    echo "Cloning the repository to $INSTALL_PATH..."
    git clone "$REPO_URL" "$INSTALL_PATH" || { echo "Failed to clone the repository."; exit 1; }
fi

# Change into the directory where the repository has been cloned
cd "$INSTALL_PATH" || { echo "Failed to change directory to $INSTALL_PATH"; exit 1; }

# Move ssh-bible-verse.sh to /etc/profile.d and set execute permissions
echo "Setting up the ssh-bible-verse script..."
if [ -f "sshverse.sh" ]; then
    chmod +x "sshverse.sh"
    sudo mv "sshverse.sh" "/etc/profile.d/sshverse.sh" || { echo "Failed to move and set permissions for sshverse.sh"; exit 1; }
else
    echo "sshverse.sh not found in the cloned repository."
    exit 1
fi

echo "Installation completed successfully."
