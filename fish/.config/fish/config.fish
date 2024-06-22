set -x EDITOR nvim
set -U fish_greeting
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin ~/pact/bin
set -x PATH $PATH $HOME/bin
set -x PATH $PATH ~/.emacs.d/bin
set -x PATH $PATH ~/.luarocks/bin
set -x PATH $PATH ~/.cargo/bin
set -x PATH $PATH ~/.dotnet ~/.dotnet/tools
set -x TFENV_ARCH amd64 # Terraform M1 compatibility

# For demucs on WSL2
# set -x LD_LIBRARY_PATH="/usr/lib/wsl/lib:$LD_LIBRARY_PATH"

# Haskell
set -x PATH $PATH ~/.ghcup/bin
set -x PATH $PATH ~/.cabal/bin

set -gx CLICOLOR 1
set -x COLORTERM truecolor
set -x BAT_THEME "Dracula"

set -x FZF_CTRL_T_COMMAND 'fd --exclude .git --exclude node_modules --exclude .mypy_cache --exclude Applications --exclude Library --exclude Movies --exclude Pictures'
set -x FZF_DEFAULT_OPTIONS '--keep-right'
set -x CDIFF_OPTIONS '-s -w0'

# source ~/.ghcup/env
test -e ~/.secrets; and source ~/.secrets
source ~/.config/fish/aliases.fish
# source ~/.config/fish/nnn.fish
starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# if test -n $WSL_DISTRO_NAME
#     set -x DISPLAY (ip route list default | awk '{print $3}'):0
#     set -x LIBGL_ALWAYS_INDIRECT 1
# end

fish_add_path (brew --prefix)/sbin 
fish_add_path (brew --prefix)/bin 
fish_add_path ~/.local/share/nvim/lazy/vim-tidal/bin

# set -x PATH $PATH ~/nvim-nightly/bin

# opam configuration
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
