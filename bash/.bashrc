# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias vim='nvim'
# alias e='nvim'
#
# Use VSCode instead of neovim as your default editor
# export EDITOR="code"
#
# Set a custom prompt with the directory revealed (alternatively use https://starship.rs)
# PS1="\W \[\e]0;\w\a\]$PS1"

. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"


# Load all snippets from ~/.bashrc.d in lexical order.
BASHRC_D="$HOME/.bashrc.d"
if [ -d "$BASHRC_D" ]; then
  for f in "$BASHRC_D"/*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi


if [ -n "$SSH_CONNECTION" ]; then
    neofetch
fi
