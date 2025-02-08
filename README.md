# dotdev

A containerized development environment optimized for iPad SSH/Mosh access.

## Features
- Mosh for reliable mobile connections
- Tmux for session management
- Helix editor with LSP support
- nnn file manager
- fzf for fuzzy finding
- zsh with sensible defaults 

## Quick Start

1. Create a `.env` file (see `.env.example`):
```env
DEV_USER=youruser
DEV_PASSWORD=yourpassword
SSH_PORT=2222
MOSH_PORTS=62000-62100
WORKSPACE_DIR=./workspace
HOST_SSH_DIR=~/.ssh
TZ=UTC
```

2. Start the container:
```bash
docker-compose up -d
```

3. Connect:
```bash
# SSH
ssh -p 2222 youruser@localhost

# Mosh
mosh --ssh="ssh -p 2222" youruser@localhost
```

## Customization

Modify configurations in the `dotfiles/` directory:
```
dotfiles/
├── tmux/.tmux.conf    # Tmux config
├── helix/config.toml  # Helix editor config
├── zsh/.zshrc         # Zsh shell config
└── fzf/.fzf.zsh      # Fuzzy finder config
```

Changes are reflected in the container through volume mounts. Your host's SSH keys and configurations are automatically available in the container.