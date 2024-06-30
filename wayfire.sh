# Add Wayfire repository
echo "deb [arch=armhf] http://deb.wayfire.org/ bookworm main" | sudo tee /etc/apt/sources.list.d/wayfire.list

# Add Wayfire GPG key
curl -fsSL https://deb.wayfire.org/wayfire.gpg | sudo apt-key add -

# Update package list
sudo apt update

# Install Wayfire
sudo apt install -y wayfire

# Optionally install additional components
sudo apt install -y wayfire-plugins-extra wofi xwayland
