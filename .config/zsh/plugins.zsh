# Plugins and prompt (plugins come from pacman). The order is tested and matters:
# syntax highlighting goes after everything else that touches the input line,
# and history substring search goes right after it.

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf: Ctrl+R history, Ctrl+T files, Alt+C directories
source /usr/share/fzf/key-bindings.zsh

# Starship prompt
eval "$(starship init zsh)"

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
