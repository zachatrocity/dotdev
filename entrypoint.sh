#!/bin/bash

# Create user with provided username and password
if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    # Create user and add to wheel group for sudo access
    adduser -D -s /bin/zsh "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    addgroup "$USERNAME" wheel

    # Set ownership of home directory
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"

    # Create necessary config directories
    mkdir -p "/home/$USERNAME/.config"
    mkdir -p "/home/$USERNAME/.config/nnn"
    mkdir -p "/home/$USERNAME/.config/nvim"
    
    # Set ownership of config directories
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config/nnn"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.config/nvim"
    
    # Setup zsh history file with proper permissions
    touch "/home/$USERNAME/.zsh_history"
    chown "$USERNAME:$USERNAME" "/home/$USERNAME/.zsh_history"
    chmod 644 "/home/$USERNAME/.zsh_history"

    # Configure sudo access for wheel group
    echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
    chmod 440 /etc/sudoers.d/wheel
fi

# Ensure SSH directory exists
if [ ! -d "/home/$USERNAME/.ssh" ]; then
    # Set restrictive permissions on SSH files
    echo ".ssh directory not found, did you map the volume?"
fi

exec "$@"
