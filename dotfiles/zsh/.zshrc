# Source Antigen
source /usr/local/share/antigen/antigen.zsh

# Load Oh My Zsh
antigen use oh-my-zsh

# Load plugins
antigen bundle git
antigen bundle docker
antigen bundle tmux
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load theme
antigen theme robbyrussell

# Apply Antigen configuration
antigen apply

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Initialize the completion system
autoload -Uz compinit
compinit

# Use vim keys in tab complete menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# Environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export TERM=xterm-256color

# FZF configuration
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Custom functions
function mkcd() {
    mkdir -p "$@" && cd "$@"
}

# nnn configuration
export NNN_OPTS="deH"  # Show details, hidden files
export NNN_COLORS="2136"  # Different colors for different file types
export NNN_TRASH=1  # Enable trash instead of delete
export NNN_FIFO=/tmp/nnn.fifo  # For preview-tui
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview'  # Plugins

# nnn cd on quit
n ()
{
    # Block nnn if no arguments and no stdin (empty pipe)
    [ -n "$1" ] || [ -p /dev/stdin ] || return

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# Load custom configurations
if [ -d ~/.zsh.d ]; then
    for file in ~/.zsh.d/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
fi

# Cargo configuration
export PATH="$HOME/.cargo/bin:$PATH"

# Auto-start tmux with neovim in workspace when connecting via SSH
if [ -n "$SSH_CONNECTION" ]; then
    # If not already in tmux, start a new session
    if [ -z "$TMUX" ]; then
        cd ~/workspace
        # Create a new tmux session named 'dev' and start neovim
        tmux new-session -s dev 'nvim'
    fi
fi
