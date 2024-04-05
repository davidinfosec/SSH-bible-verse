#!/bin/bash

# Define the base path for installation
INSTALL_PATH="/opt/SSH-bible-verse"
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse"

# Step 1: Clone the repository
echo "Cloning the repository to $INSTALL_PATH..."
git clone "$REPO_URL" "$INSTALL_PATH" || { echo "Failed to clone the repository."; exit 1; }

# Change into the directory where the repository has been cloned
cd "$INSTALL_PATH" || { echo "Failed to change directory to $INSTALL_PATH"; exit 1; }

# Step 3: Move ssh-bible-verse.sh to /etc/profile.d and set execute permissions
echo "Setting up the ssh-bible-verse script..."
if [ -f "ssh_bible_verse.sh" ]; then
    chmod +x "ssh_bible_verse.sh"
    mv "ssh_bible_verse.sh" "/etc/profile.d/ssh_bible_verse.sh" || { echo "Failed to move and set permissions for ssh_bible_verse.sh"; exit 1; }
else
    echo "ssh_bible_verse.sh not found in the cloned repository."
    exit 1
fi

echo "Installation completed successfully."
