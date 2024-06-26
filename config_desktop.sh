################ Phase 4: Configure the desktop for LXQt ################
# Remove images
WALLPAPER_DIR="/usr/share/lxqt/wallpapers"
GRAPH_DIR="/usr/share/lxqt/graphics"
sudo rm -f $WALLPAPER_DIR/*
sudo rm -f $GRAPH_DIR/*

# Download the new image from GitHub
sudo wget -O $WALLPAPER_DIR/$"wallpaper1.svg" $"https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/resources/wallpaper1.svg"
sudo wget -O $WALLPAPER_DIR/$"wallpaper2.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/resources/wallpaper2.png"
sudo wget -O $GRAPH_DIR/$"settings_icon.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/resources/settings_icon.png"

# Download configuration change_menu
config_url="https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/configration"

# Define an associative array with local paths as keys and remote file names as values
declare -A config_dir=(
    ["$HOME/.config/openbox/rc.xml"]="rc.xml"
    ["$HOME/.config/lxqt/lxqt.conf"]="lxqt.conf"
    ["$HOME/.config/lxqt/lxqt-config-locale.conf"]="lxqt-config-locale.conf"
    ["$HOME/.config/lxqt/panel.conf"]="panel.conf"
    ["$HOME/.config/lxqt/session.conf"]="session.conf"
    ["$HOME/.config/pcmanfm-qt/lxqt/settings.conf"]="settings.conf"
    ["/media/pi/rootfs/usr/share/lightdm/lightdm-gtk-greeter.conf.d/01_debian.conf"]="01_debian.conf"
)

# Loop through the array and download each file
for local_path in "${!config_dir[@]}"; do
    remote_file="${config_dir[$local_path]}"
    remote_url="$config_url/$remote_file"

    mkdir -p "$(dirname "$local_path")"     # Create the directory if it does not exist
    wget -O "$local_path" "$remote_url"     # Download the file/replace the file

done

# Update the menu items
menu_url="https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/configration/"
change_menu=(
    "htop.desktop"
    "lxqt-config.desktop"
    "obconf.desktop"
    "pcmanfm-qt.desktop"
    "qterminal.desktop"
)

# Loop through change_menu and download
for file in "${change_menu[@]}"; do
    sudo wget -O "/usr/share/applications/${file}" "${menu_url}${file}"
done
sudo wget -O /etc/xdg/menus/lxqt-applications.menu https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/configration/lxqt-applications.menu

remove_menu=(
    "system-config-printer.desktop"
    "lxqt-leave.desktop"
    "lxqt-hibernate.desktop"
    "lxqt-suspend.desktop"
    "lxqt-lockscreen.desktop"
    "qterminal-drop.desktop"
    "vim.desktop"
)

# Remove existing files
for file in "${remove_menu[@]}"; do
    sudo rm "/usr/share/applications/${file}"
done

echo "##################################################################"
echo "########################## Phase 4 done ##########################"
sleep 2


