#!/bin/bash

# Define variables
REPO_URL="https://github.com/davidinfosec/SSH-bible-verse.git"
INSTALL_DIR="/opt/bible"

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Install dependencies (jq, git)
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    apt-get update && apt-get install -y jq
fi

if ! command -v git &> /dev/null; then
    echo "Installing git..."
    apt-get install -y git
fi

# Clone the Bible repository
echo "Cloning Bible repository to $INSTALL_DIR..."
git clone "$REPO_URL" "$INSTALL_DIR" || { echo "Failed to clone repository."; exit 1; }

# Create the display script in /etc/profile.d
SCRIPT_PATH="/etc/profile.d/ssh_bible_verse.sh"
echo "Creating the display script at $SCRIPT_PATH..."
cat << 'EOF' > "$SCRIPT_PATH"
#!/bin/bash

# Define base paths for OT and NT directories
OT_PATH="/opt/bible/OT"
NT_PATH="/opt/bible/NT"

# Select randomly between OT and NT
if [ \$((RANDOM % 2)) -eq 0 ]; then
    BOOK_PATH="\$OT_PATH"
else
    BOOK_PATH="\$NT_PATH"
fi

# Find all JSON files under the selected testament path and pick one at random
SCRIPT=\$(find \$BOOK_PATH -type f -name "*.json" | shuf -n 1)

# Extract a random verse from the selected JSON file
VERSE=\$(jq -r '[.text[].text[]] | .[] | "\(.ID) \(.text)"' \$SCRIPT | shuf -n 1)

# Output the selected verse
echo \$VERSE
EOF

# Make the display script executable
chmod +x "$SCRIPT_PATH"

echo "Installation complete. A random Bible verse will be displayed on SSH login."
