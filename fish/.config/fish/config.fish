# set environment variables
source (dirname (status --current-filename))/env.fish
if test -f (dirname (status --current-filename))/env.local.fish
    source (dirname (status --current-filename))/env.local.fish
end

starship init fish | source # https://starship.rs/
zoxide init fish | source # 'ajeetdsouza/zoxide'

# set abbreviations
source (dirname (status --current-filename))/abbr.fish
# set aliases
source (dirname (status --current-filename))/alias.fish
# set custom keybindings
source (dirname (status --current-filename))/keybindings.fish

# To do something only in interactive shells
if status is-interactive
    atuin init fish | source # https://atuin.sh/
end
