# Remote Development Environment

Alpine-based containerized development environment optimized for iPad SSH/Mosh access.

## Features

- Mosh for reliable mobile connections and session persistence
- LazyVim with tree-sitter and LSP support
- FZF for fuzzy finding
- nnn file manager
- Zsh with vi mode

## Quick Start

1. Create `.env` file from example:
```bash
cp .env.example .env
```

Default configuration:
- User: devuser (password: changeme)
- SSH port: 2222
- Mosh ports: 62000-62100 (UDP)
- Workspace mounted from ./workspace
- SSH keys from ~/.ssh

2. Build and start:
```bash
docker-compose up -d
```

3. Connect:
```bash
# SSH (first time, accept the host key)
ssh -p 2222 devuser@localhost

# Or Mosh (recommended)
mosh --ssh="ssh -p 2222" devuser@localhost
```

## Development Testing

For quick testing, comment out the sshd CMD in Dockerfile and use:
```bash
docker run -it --rm \
  -e USERNAME=dev \
  -e PASSWORD=dev \
  -v $PWD/dotfiles:/home/dev/.dotfiles \
  your-image-name
```

## Directory Structure
```
.
├── Dockerfile           # Alpine-based image configuration
├── docker-compose.yml   # Container orchestration
├── entrypoint.sh       # User and environment setup
└── dotfiles/
    ├── nvim/           # LazyVim configuration
    └── zsh/            # Zsh configuration
```

## Default Behavior

On SSH/Mosh connection:
- Automatically opens nvim in workspace directory
- Session persistence through mosh
- Full LazyVim IDE features
