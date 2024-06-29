#!/bin/bash

# Function to download specified files from a GitHub folder URL to a specified directory
# Arguments:
#   $1: GitHub folder URL
#   $2: Array of files to download
function download_files {
    github_folder_url="$1"
    files=("${@:2}")

    local_file_dir="/usr/local/bin/"
    local_app_dir="$HOME/.local/share/applications/"

    # Loop through each file and download to the appropriate directory
    for file in "${files[@]}"; do
        # Determine target directory based on file type
        if [[ "$file" == *.desktop ]]; then
            target_dir="$local_app_dir"
        else
            target_dir="$local_file_dir"
        fi

        # Create directory if it does not exist
        mkdir -p "$target_dir"

        # Download file
        curl -sS "${github_folder_url}${file}" -o "${target_dir}${file}"
    done
}

# Download files:
file_url="https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/configuration/"
files_to_download=(
    "styles.py"
    "functions.sh"
)
download_files "$file_url" "${files_to_download[@]}"

# Download apps
app_builder_url="https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/apps/app_builder/"
app_builder_download=(
    "AppBuilder.desktop"
    "app_builder.py"
    "app_builder_icon.png"
)
download_files "$app_builder_url" "${app_builder_download[@]}"
