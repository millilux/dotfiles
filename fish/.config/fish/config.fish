set -x EDITOR nvim
set -g -x SHELL fish
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

# Hack to get OMF and FZF to play nicely: https://github.com/junegunn/fzf/issues/851
function fish_user_key_bindings
  fzf_key_bindings
  #fish_vi_key_bindings insert
end

set -x CDIFF_OPTIONS '-s -w0'

# source ~/.ghcup/env
source ~/.secrets
source ~/.config/fish/aliases.fish
source ~/.config/fish/nnn.fish
set -g fish_user_paths "/usr/local/bin" $fish_user_paths

starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

