set -x EDITOR nvim
set -g -x SHELL fish
set -U fish_greeting
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin ~/pact/bin
set -x PATH $PATH $HOME/bin
set -x PATH $PATH ~/.emacs.d/bin

# Haskell
set -x PATH $PATH ~/.ghcup/bin
set -x PATH $PATH ~/.cabal/bin

set -gx CLICOLOR 1
set -gx TERM xterm-256color
set -x COLORTERM truecolor
set -x BAT_THEME "Dracula"

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
set -x CDIFF_OPTIONS '-s -w0'

# source ~/.ghcup/env
test -e ~/.secrets; and source ~/.secrets
source ~/.config/fish/aliases.fish
# source ~/.config/fish/nnn.fish
starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -U fish_user_paths (brew --prefix)/bin/ $fish_user_paths
