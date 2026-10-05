# Zsh config loader: modules live in ~/.config/zsh, the order below matters
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

for module in env shell aliases plugins; do
  source "$ZSH_CONFIG_DIR/$module.zsh"
done
unset module ZSH_CONFIG_DIR
