# SSH-bible-verse
Random bible verse on SSH connection

1. **Clone the Bible content from a GitHub repository to `/opt/SSH-bible-verse/bible`**.
2. **Install a script that displays a random Bible verse to `/etc/profile.d` and ensures it's executable**.
3. **Make necessary preparations for running the script automatically upon SSH login**.

#### Installation Instructions:

1 command install:
```
sudo apt-get install jq -y && sudo apt-get install curl && sh -c "$(curl -fsSL https://raw.githubusercontent.com/davidinfosec/SSH-bible-verse/main/install.sh)"
```



https://github.com/davidinfosec/SSH-bible-verse/assets/87215831/2cf3dc43-26bb-4591-862b-b48d920c8615




1. **Prepare the Installation Script**: 
   - Save the above script as `install.sh` on your server.
   - Ensure you replace `https://github.com/davidinfosec/SSH-bible-verse/` with the actual URL of your GitHub repository where the Bible content (e.g., `kjv.json`) is stored.

2. **Run the Installation Script**:
   - Execute the script with root privileges:
     ```bash
     sudo bash install.sh
     ```
   - The script will:
     - Check for and install `jq` and `curl` if they're not already installed.
     - Clone the Bible content to `/opt/bible`.
     - Create a script named `sshverse.sh` in `/etc/profile.d` that selects and displays a random Bible verse upon SSH login.
     - Ensure the display script is executable.

#### Usage:

- **SSH into Your Server**: After installation, whenever a user logs in via SSH, a random Bible verse will be displayed.
- **Manual Display**: You can manually display a random Bible verse by running the script directly:
  ```bash
  bash /etc/profile.d/sshverse.sh
  ```

#### Customization:

- **Changing the Bible Repository**: If you want to use a different repository for the Bible content, modify the `REPO_URL` variable in the installation script (`install.sh`) accordingly.
- **Script Customization**: The display script (`sshverse.sh`) can be edited for customization or extended functionality directly at `/etc/profile.d/sshverse.sh`.

### Final Notes:

- Ensure Git, `jq`, and `curl` are installed on your system before running the installation script (`install.sh`).
- This installation and the display script are designed for systems with `bash`, `jq`, `curl`, and `git` available and may need adjustments for other environments.
- Review and test the script in a safe environment before deploying to production to ensure it meets your needs.
- .json bible files were taken from the https://github.com/bobuk/holybooks/ repository.
```
