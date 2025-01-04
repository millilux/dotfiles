fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path ~/.emacs.d/bin
fish_add_path ~/.luarocks/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.dotnet ~/.dotnet/tools

set -U fish_greeting
set -x EDITOR nvim
set -x GOPATH $HOME/go
set -x TFENV_ARCH amd64 # Terraform M1 compatibility

# For demucs on WSL2
# set -x LD_LIBRARY_PATH="/usr/lib/wsl/lib:$LD_LIBRARY_PATH"

# Theme
set -gx CLICOLOR 1
set -x COLORTERM truecolor
set -x BAT_THEME "Dracula"

# FZF
set -x FZF_CTRL_T_COMMAND 'fd --exclude .git --exclude node_modules --exclude .mypy_cache --exclude Applications --exclude Library --exclude Movies --exclude Pictures'
set -x FZF_DEFAULT_OPTIONS '--keep-right'
set -x CDIFF_OPTIONS '-s -w0'

if test -x "$(command -v fzf)"
    source /usr/share/fzf/shell/key-bindings.fish
end

# Haskell
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cabal/bin
# source ~/.ghcup/env

test -e ~/.secrets; and source ~/.secrets
source ~/.config/fish/aliases.fish
# source ~/.config/fish/nnn.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# if test -n $WSL_DISTRO_NAME
#     set -x DISPLAY (ip route list default | awk '{print $3}'):0
#     set -x LIBGL_ALWAYS_INDIRECT 1
# end

if test -x "$(command -v brew)"
    fish_add_path (brew --prefix)/sbin 
    fish_add_path (brew --prefix)/bin 
end
fish_add_path ~/.local/share/nvim/lazy/vim-tidal/bin

# opam configuration
#test -r $HOME/.opam/opam-init/init.fish && source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

~/.local/bin/mise activate fish | source
starship init fish | source
zoxide init fish | source
