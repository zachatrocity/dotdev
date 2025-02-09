# 🚀 Remote Development Environment

A supercharged, containerized development environment optimized for iPad SSH/Mosh access! 

## ✨ Features

- 🔄 Mosh for reliable mobile connections and session persistence
- 🧠 AI-powered coding with avante.nvim + OpenRouter
- 🛠️ LazyVim with tree-sitter and LSP support
- 🔍 FZF for fuzzy finding
- 📁 nnn file manager
- 🐚 Zsh with Oh My Zsh + Antigen
  - 🎨 Syntax highlighting
  - 💡 Command suggestions
  - 🔧 Git integration
  - 🐳 Docker integration
- 🖥️ Tmux with sensible defaults
  - 📌 Session persistence
  - 🔌 Plugin management via tpm
  - 🎯 Auto-start with neovim

## 🏃‍♂️ Quick Start

1. Create `.env` file from example:
```bash
cp .env.example .env
```

Default configuration:
- 👤 User: devuser (password: changeme)
- 🔒 SSH port: 2222
- 📡 Mosh ports: 62000-62100 (UDP)
- 📂 Workspace mounted from ./workspace
- 🔑 SSH keys from ~/.ssh

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

## 🛠️ Development Testing

For quick testing, comment out the sshd CMD in Dockerfile and use:
```bash
docker run -it --rm \
  -e USERNAME=dev \
  -e PASSWORD=dev \
  -v $PWD/dotfiles:/home/dev/.dotfiles \
  your-image-name
```

## 📁 Directory Structure
```
.
├── Dockerfile           # Alpine-based image configuration
├── docker-compose.yml   # Container orchestration
├── entrypoint.sh       # User and environment setup
└── dotfiles/
    ├── nvim/           # LazyVim configuration
    ├── tmux/           # Tmux configuration
    └── zsh/            # Zsh configuration
```

## 🎯 Default Behavior

On SSH/Mosh connection:
- 🏃‍♂️ Automatically starts a tmux session
- 📝 Opens neovim in workspace directory
- 💾 Session persistence through mosh
- 🎨 Full LazyVim IDE features

## 🔧 Post-Installation

1. Install tmux plugins:
   - Press `prefix + I` (capital i) to install configured plugins

2. For AI features:
   - Set up your OpenRouter API key in environment variables
   - Use `<leader>aa` to toggle AI assistant
   - Use `<C-s>` to submit prompts
   - Use `<Tab>` / `<S-Tab>` to accept/reject suggestions

## 🌟 Tips

- 🔄 Use Mosh for better mobile connectivity
- 🎨 Customize your theme through Oh My Zsh
- 🔌 Add more plugins via Antigen in .zshrc
- ⚡ Enjoy seamless development from anywhere!
