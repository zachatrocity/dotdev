# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Basic auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
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

# Useful aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias hx='helix'

# Environment variables
export EDITOR='hx'
export VISUAL='hx'
export TERM=xterm-256color

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# Cargo and Helix configuration
export PATH="$HOME/.cargo/bin:$PATH"
export HELIX_RUNTIME="/usr/local/lib/helix/runtime"

# Auto-start tmux on SSH connection
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    # Attach to existing session or create a new one
    tmux attach || tmux
fi
export PATH="$HOME/.cargo/bin:$PATH"
export HELIX_RUNTIME="/usr/local/lib/helix/runtime"
