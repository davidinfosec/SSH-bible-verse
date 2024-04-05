# SSH-bible-verse
Random bible verse on SSH connection

Certainly! Below is a guide and a sample installation script that will:

1. Clone the Bible content from a GitHub repository to `/opt/bible`.
2. Install a script that displays a random Bible verse to `/etc/profile.d` and ensures it's executable.
3. Make necessary preparations for running the script automatically upon SSH login.

#### Installation Instructions:

1. **Prepare the Installation Script**: 
   - Save the above script as `install_ssh_verse.sh` on your server.
   - Ensure you replace `https://github.com/davidinfosec/SSH-bible-verse/` with the actual URL of your GitHub repository where the Bible content is stored.

2. **Run the Installation Script**:
   - Execute the script with root privileges:
     ```bash
     sudo bash install_ssh_verse.sh
     ```
   - The script will:
     - Check for and install `jq` if it's not already installed.
     - Clone the Bible content to `/opt/bible`.
     - Create a script in `/etc/profile.d` that selects and displays a random Bible verse upon SSH login.
     - Ensure the display script is executable.

#### Usage:

- **SSH into Your Server**: After installation, whenever a user logs in via SSH, a random Bible verse will be displayed.
- **Manual Display**: You can manually display a random Bible verse by running the script directly:
  ```bash
  bash /etc/profile.d/bible_verse.sh
  ```

#### Customization:

- **Changing the Bible Repository**: If you want to use a different repository for the Bible content, modify the `REPO_URL` variable in the installation script accordingly.
- **Script Customization**: The display script can be edited for customization or extended functionality directly at `/etc/profile.d/bible_verse.sh`.

### Final Notes:

- Ensure Git is installed on your system before running the installation script.
- This installation and the display script are designed for systems with `bash`, `jq`, and `git` available and may need adjustments for other environments.
- Review and test the script in a safe environment before deploying to production to ensure it meets your needs.
