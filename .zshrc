# nvm (Node version manager)
source /usr/share/nvm/init-nvm.sh

# Personal scripts and tools
export PATH="$HOME/.local/bin:$PATH"

# SDKMAN (Java, Gradle, etc.)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# Key bindings
# Ctrl+Backspace: delete word left
bindkey '^H' backward-kill-word

# Ctrl+Left / Ctrl+Right: move by word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl+Delete: delete word right
bindkey '^[[3;5~' kill-word
