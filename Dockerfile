FROM ubuntu:22.04

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and development tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    mosh \
    tmux \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    ripgrep \
    fd-find \
    pkg-config \
    libssl-dev \
    nnn \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Install and configure FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && \
    mkdir -p /usr/share/fzf && \
    cp ~/.fzf/shell/completion.zsh /usr/share/fzf/ && \
    cp ~/.fzf/shell/key-bindings.zsh /usr/share/fzf/

# Install Rust and build helix editor
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install --git https://github.com/helix-editor/helix --locked helix-term && \
    ln -s ~/.cargo/bin/hx /usr/local/bin/hx && \
    ln -s ~/.cargo/bin/hx /usr/local/bin/helix && \
    chmod 755 ~/.cargo/bin/hx && \
    chmod 755 /usr/local/bin/hx && \
    chmod 755 /usr/local/bin/helix 

# Create SSH directory
RUN mkdir /var/run/sshd

# Script to create user and setup environment
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22 62000-62100/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

# For development, comment out the sshd CMD above and use this instead:
# CMD ["/bin/zsh"]
# Then run with: docker run -it --rm -e USERNAME=dev -e PASSWORD=dev -v $PWD/dotfiles:/home/dev/.dotfiles your-image-name
