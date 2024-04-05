#!/bin/bash

# Define variables
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse"  # Replace with your repository URL
INSTALL_DIR="/opt/bible"
SCRIPT_NAME="ssh-bible-verse.sh"
SCRIPT_PATH="/etc/profile.d/$SCRIPT_NAME"

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Install jq if not installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    apt-get update && apt-get install -y jq
fi

# Clone the Bible repository
echo "Cloning Bible repository to $INSTALL_DIR..."
git clone "$REPO_URL" "$INSTALL_DIR" || { echo "Failed to clone repository."; exit 1; }

# Create the display script
echo "Creating the display script..."
cat << EOF > "$SCRIPT_PATH"
#!/bin/bash
# Random Bible Verse Display Script
BIBLE_DIR="$INSTALL_DIR"
SCRIPT=\$(find \$BIBLE_DIR -type f -name "*.json" | shuf -n 1)
VERSE=\$(jq -r '.text[].text[] | .[] | "\(.ID) \(.text)"' \$SCRIPT | shuf -n 1)
echo \$VERSE
EOF

# Make the display script executable
chmod +x "$SCRIPT_PATH"

echo "Installation complete. A random Bible verse will be displayed on SSH login."
