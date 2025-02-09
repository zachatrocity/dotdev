# 🚀 Remote Development Environment

A supercharged, containerized development environment optimized for iPad SSH/Mosh access.

## ✨ Features

- 🔄 Mosh for reliable mobile connections and session persistence
- 🧠 AI-powered coding with avante.nvim + OpenRouter
- 🛠️ LazyVim with tree-sitter and LSP support
- 🔍 FZF for fuzzy finding
- 🐚 Zsh with Oh My Zsh + Antigen
  - 🎨 Syntax highlighting
  - 💡 Command suggestions
  - 🔧 Git integration
- 🖥️ Tmux with sensible defaults

## 🏃‍♂️ Quick Start

1. Create `.env` file from example:
```bash
cp .env.example .env
```

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

## 📁 Directory Structure
```
.
├── dotfiles/           # Version-controlled configurations
│   ├── nvim/          # LazyVim configuration
│   ├── tmux/          # Tmux configuration
│   └── zsh/           # Zsh configuration
└── home/              # Persistent home directory (auto-created)
```

## 🔧 Configuration

Example docker-compose.yml:
```yaml
services:
  devdot:
    build: .
    ports:
      - "${SSH_PORT}:22"
      - "${MOSH_PORTS}:62000-62100/udp"
    volumes:
      - ./workspace:/home/${DEV_USER}/workspace
      - ~/.ssh:/home/${DEV_USER}/.ssh:ro
      - ./home:/home/${DEV_USER}
      - ./dotfiles:/home/${DEV_USER}/dotfiles
```

## 🎯 Post-Installation

1. Install tmux plugins:
   - Press `prefix + I` (capital i)

2. For AI features:
   - Set up your OpenRouter API key
   - Use `<Space>aa` to toggle AI assistant
   - Use `<C-s>` to submit prompts

## 🌟 Tips

- 🔄 Use Mosh for better mobile connectivity
- 🎨 Customize your theme through Oh My Zsh
- 🔌 Add more plugins via Antigen in .zshrc
