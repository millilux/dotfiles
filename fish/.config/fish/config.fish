fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path ~/.emacs.d/bin
fish_add_path ~/.luarocks/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.dotnet ~/.dotnet/tools
fish_add_path ~/.opencode/bin

set -U fish_greeting
set -x EDITOR nvim
set -x GOPATH $HOME/go
set -x TFENV_ARCH amd64 # Terraform M1 compatibility
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x ELECTRON_OZONE_PLATFORM_HINT auto
# For demucs on WSL2
# set -x LD_LIBRARY_PATH="/usr/lib/wsl/lib:$LD_LIBRARY_PATH"

# Theme
set -gx CLICOLOR 1
set -x COLORTERM truecolor
set -x BAT_THEME "Dracula"

# FZF
# set -x FZF_CTRL_T_COMMAND fd --exclude .git --exclude node_modules --exclude .mypy_cache --exclude Applications --exclude Library --exclude Movies --exclude Pictures -tf -x echo {/} {//} {} | fzf -d '\s' --with-nth 1..-2 --bind='enter:become(echo {3})'
set -x FZF_CTRL_T_COMMAND 'fd --exclude .git --exclude node_modules --exclude .mypy_cache --exclude Applications --exclude Library --exclude Movies --exclude Pictures'
#set -x FZF_CTRL_T_OPTS "--bind 'enter:execute(vim {})'"
set -x FZF_DEFAULT_OPTIONS '--keep-right'
set -x CDIFF_OPTIONS '-s -w0'

if test -x "$(command -v fzf)"
    fzf --fish | source
end

# Haskell
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cabal/bin
# source ~/.ghcup/env


test -e ~/.secrets; and source ~/.secrets
source ~/.config/fish/aliases.fish
# source ~/.config/fish/nnn.fish

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
test -r $HOME/.opam/opam-init/init.fish && source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

mise activate fish | source
starship init fish | source
zoxide init fish | source
