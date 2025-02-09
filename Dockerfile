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
    font-jetbrains-mono-nerd

# Setup SSH
RUN ssh-keygen -A && \
    mkdir -p /var/run/sshd

# Install tmux plugin manager
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tree-sitter (required for neovim)
RUN npm install -g tree-sitter-cli

# Configure fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && \
    mkdir -p /usr/share/fzf && \
    cp ~/.fzf/shell/completion.zsh /usr/share/fzf/ && \
    cp ~/.fzf/shell/key-bindings.zsh /usr/share/fzf/

# Script to create user and setup environment
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22 62000-62100/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

# For development, comment out the sshd CMD above and use this instead:
# CMD ["/bin/zsh"]
# Then run with: docker run -it --rm -e USERNAME=dev -e PASSWORD=dev -v $PWD/dotfiles:/home/dev/.dotfiles your-image-name
