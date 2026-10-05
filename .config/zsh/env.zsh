# Environment and toolchains (order matters for PATH precedence)

# nvm (Node version manager)
source /usr/share/nvm/init-nvm.sh

# Personal scripts and tools
export PATH="$HOME/.local/bin:$PATH"

# SDKMAN (Java, Gradle, etc.)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Default editor
export EDITOR=nvim
export VISUAL=nvim
