#!/bin/bash

# Define the base path for installation
INSTALL_PATH="/opt/SSH-bible-verse"
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse"
REPO_NAME="SSH-bible-verse"

# Step 1: Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" "$INSTALL_PATH" || { echo "Failed to clone the repository."; exit 1; }

# Step 2: Check and move the Bible content to the target location
# Note: Since we cloned the entire repo to the target location, this step might not be necessary.

# Step 3: Move ssh-bible-verse.sh to /etc/profile.d and set execute permissions
echo "Setting up the ssh-bible-verse script..."
if [ -f "$INSTALL_PATH/ssh-bible-verse.sh" ]; then
    chmod +x "$INSTALL_PATH/ssh-bible-verse.sh"
    mv "$INSTALL_PATH/ssh-bible-verse.sh" "/etc/profile.d/ssh-bible-verse.sh" || { echo "Failed to move and set permissions for ssh-bible-verse.sh"; exit 1; }
else
    echo "ssh-bible-verse.sh not found in the cloned repository."
    exit 1
fi

echo "Installation completed successfully."
