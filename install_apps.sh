#!/bin/bash

# Function to download all files from a GitHub folder
# Arguments:
#   $1: GitHub folder URL
function download_apps {
    github_folder_url="$1"
    local_file_dir="/usr/local/bin/" # Local directory for non-.desktop files
    local_app_dir="~/.local/share/applications/" # Local directory for .desktop files

    # Fetch list of files from GitHub folder using GitHub API (assuming GitHub raw URL)
    files=$(curl -sS "${github_folder_url}?recursive=1" | grep -oP '"path":"\K[^"]+' | grep -v '/$')

    # Loop through each file and download to the appropriate directory
    for file in ${files[@]}; do
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

# Example usage:
app_builder_url="https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/apps/app_builder/"
download_apps "$app_builder_url"
