set -x EDITOR nvim
set -g -x SHELL fish
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin ~/pact/bin
set -x PATH $PATH $HOME/bin

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set -g theme_color_scheme gruvbox

function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal

 # if set -q VIRTUAL_ENV
  #    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  # end
end

alias vim 'nvim'
alias vimdiff 'nvim -d'

# Setup virtualfish
# eval (python3 -m virtualfish)


set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

# Hack to get OMF and FZF to play nicely: https://github.com/junegunn/fzf/issues/851
function fish_user_key_bindings
  fzf_key_bindings
end

set -x CDIFF_OPTIONS '-s -w0'

source ~/.secrets
source ~/.config/fish/aliases.fish
