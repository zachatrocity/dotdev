FROM alpine:edge

# Install essential packages and development tools
RUN apk add --no-cache \
    # Base development tools
    alpine-sdk \
    bash \
    curl \
    git \
    lazygit \
    mosh \
    neovim \
    nodejs \
    npm \
    openssh \
    python3 \
    py3-pip \
    ripgrep \
    fd \
    sudo \
    tmux \
    zsh \
    # Build dependencies
    fontconfig \
    unzip \
    # Additional tools
    fzf \
    nnn \
    # Required for proper locale support
    musl-locales \
    # Required for proper font rendering
    font-jetbrains-mono-nerd \
    # Required for Oh My Zsh
    wget \
    git

# Install Antigen (ZSH Plugin Manager)
RUN mkdir -p /usr/local/share/antigen && \
    curl -L git.io/antigen > /usr/local/share/antigen/antigen.zsh

# Install TPM (Tmux Plugin Manager)
RUN git clone https://github.com/tmux-plugins/tpm /usr/local/share/tpm

# Setup SSH
RUN ssh-keygen -A && \
    mkdir -p /var/run/sshd

# Install tree-sitter (required for neovim)
RUN npm install -g tree-sitter-cli

# Script to create user and setup environment
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22 62000-62100/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

# For development, comment out the sshd CMD above and use this instead:
# CMD ["/bin/zsh"]
# Then run with: docker run -it --rm -e USERNAME=dev -e PASSWORD=dev -v $PWD/dotfiles:/home/dev/.dotfiles your-image-name
