#!/bin/bash

# Create user with provided username and password
if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    # Create user and add to wheel group for sudo access
    adduser -D -s /bin/zsh "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    addgroup "$USERNAME" wheel

    # Set ownership of home directory
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"

    # Create necessary directories
    mkdir -p "/home/$USERNAME/.config"
    mkdir -p "/home/$USERNAME/.local/share"
    mkdir -p "/home/$USERNAME/.local/state"
    mkdir -p "/home/$USERNAME/.cache"
    
    # Install Oh My Zsh for the user
    su - "$USERNAME" -c 'sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended'
    
    # Setup symlinks from dotfiles
    ln -sf "/home/$USERNAME/dotfiles/nvim" "/home/$USERNAME/.config/nvim"
    ln -sf "/home/$USERNAME/dotfiles/zsh/.zshrc" "/home/$USERNAME/.zshrc"
    ln -sf "/home/$USERNAME/dotfiles/tmux/tmux.conf" "/home/$USERNAME/.tmux.conf"
    
    # Setup tmux plugin manager
    mkdir -p "/home/$USERNAME/.tmux/plugins"
    ln -sf /usr/local/share/tpm "/home/$USERNAME/.tmux/plugins/tpm"
    
    # Set ownership of all home directory contents
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/"
    
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
