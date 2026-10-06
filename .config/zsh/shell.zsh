# Core shell behavior: options, history, key bindings, completion, functions

# --- Options ---
unsetopt flowcontrol
setopt interactive_comments

# --- History ---
HISTFILE="$HOME/.local/state/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}
HISTSIZE=60000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# --- Key bindings ---
# Emacs mode, set explicitly so a vi-like EDITOR does not switch zsh to vi mode
bindkey -e

# Edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# "/" is not part of a word: word-wise actions move one path segment at a time
WORDCHARS=${WORDCHARS/\/}

# Ctrl+Backspace: delete word left
bindkey '^H' backward-kill-word

# Ctrl+Left / Ctrl+Right: move by word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl+Delete: delete word right
bindkey '^[[3;5~' kill-word

# Home / End / Delete / Shift+Tab
bindkey '^[[H'  beginning-of-line      # Home
bindkey '^[[F'  end-of-line            # End
bindkey '^[[3~' delete-char            # Delete
bindkey '^[[Z'  reverse-menu-complete  # Shift+Tab

# --- Completion ---
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
eval "$(dircolors -b)"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- Functions ---
# y: yazi wrapper. On quit with "q" the shell cd's into the directory yazi
# ended in; "Q" quits without changing directory.
function y() {
  local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}
