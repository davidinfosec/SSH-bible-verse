#!/bin/bash

# Define variables
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse.git"
BIBLE_DIR="/opt/SSH-bible-verse/bible"
SCRIPT_NAME="ssh_bible_verse.sh"
SCRIPT_PATH="/etc/profile.d/$SCRIPT_NAME"

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." 1>&2
    exit 1
fi

# Install dependencies (jq, git) if they are not already installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    apt-get update && apt-get install -y jq
fi

if ! command -v git &> /dev/null; then
    echo "Installing git..."
    apt-get install -y git
fi

# Check if the BIBLE_DIR already exists and remove it to ensure fresh installation
if [ -d "$BIBLE_DIR" ]; then
    echo "Previous Bible directory found. Removing..."
    rm -rf "$BIBLE_DIR"
fi

# Clone the Bible repository into the specified BIBLE_DIR
echo "Cloning Bible repository into $BIBLE_DIR..."
git clone "$REPO_URL" "$BIBLE_DIR" || { echo "Failed to clone repository."; exit 1; }

# Create the display script in /etc/profile.d with executable permissions
echo "Creating and setting executable permissions for the display script at $SCRIPT_PATH..."
cat << 'EOF' > "$SCRIPT_PATH"
EOF
