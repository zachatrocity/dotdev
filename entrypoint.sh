#!/bin/bash

# Create user with provided username and password
if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    useradd -m -s /bin/zsh "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    usermod -aG sudo "$USERNAME"

    # Create necessary config directories
    mkdir -p "/home/$USERNAME/.config"
    mkdir -p "/home/$USERNAME/.config/nnn"
    mkdir -p "/home/$USERNAME/.cargo"
    
    # Set ownership of config directories
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config/nnn"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.cargo"
    
    # Setup cargo environment for the user
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "/home/$USERNAME/.zshrc"
    
    # Setup zsh history file with proper permissions
    touch "/home/$USERNAME/.zsh_history"
    chown "$USERNAME:$USERNAME" "/home/$USERNAME/.zsh_history"
    chmod 644 "/home/$USERNAME/.zsh_history"
    
    # Ensure helix runtime is accessible
    echo 'export HELIX_RUNTIME="/usr/local/lib/helix/runtime"' >> "/home/$USERNAME/.zshrc"
    
    # Setup FZF for the user
    mkdir -p "/home/$USERNAME/.fzf"
    cp -r /root/.fzf/* "/home/$USERNAME/.fzf/"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.fzf"
fi

# # Ensure SSH directory exists
if [ ! -d "/home/$USERNAME/.ssh" ]; then
    # Set restrictive permissions on SSH files
    echo ".ssh directory not found, did you map the volume?"
fi


exec "$@"
