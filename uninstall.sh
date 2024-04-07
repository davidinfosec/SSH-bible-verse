#!/bin/bash

# Define the base path for the installed script
INSTALL_PATH="/opt/SSH-bible-verse"

# Remove ssh-bible-verse.sh from /etc/profile.d
echo "Removing the ssh-bible-verse script from /etc/profile.d..."
if [ -f "/etc/profile.d/sshverse.sh" ]; then
    sudo rm "/etc/profile.d/sshverse.sh" || { echo "Failed to remove sshverse.sh from /etc/profile.d"; exit 1; }
else
    echo "sshverse.sh not found in /etc/profile.d. It might have already been removed."
fi

# Remove the SSH-bible-verse folder from /opt
# This step will delete the entire directory and its contents.
echo "Removing the SSH-bible-verse directory from /opt..."
if [ -d "$INSTALL_PATH" ]; then
    sudo rm -rf "$INSTALL_PATH" || { echo "Failed to remove the SSH-bible-verse directory at $INSTALL_PATH"; exit 1; }
else
    echo "The SSH-bible-verse directory $INSTALL_PATH does not exist. It might have already been removed."
fi

echo "Uninstallation completed successfully."

# Note about jq removal
echo "If jq was installed specifically for SSH-bible-verse and is no longer required, you can remove it using:"
echo "sudo apt-get remove jq"
echo "Please ensure that no other applications depend on jq before removing it."
