#!/usr/bin/env bash

set -e

# Install homebrew
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    curl -fsS https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
fi
    curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh | sh -c
exit

brew bundle Brewfile

# Make sure homebrew paths come first
sudo sed -i '' '1s!^!/opt/homebrew/bin\n!' /etc/paths

# Add fish to list of shells
if ! grep fish /etc/shells; then
    echo $(which fish) | sudo tee -a /etc/shells
fi

# Set fish as default
chsh -s /usr/local/bin/fish

# Add git completion etc
fish_update_completions

# Remove default greeting message
set fish_greeting

# Install fisher
# curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    brew bundle Brewfile.macos

    # Increase OSX Dock animation speed
    defaults write com.apple.dock autohide-time-modifier -float 0.2
    killall Dock

    # Install powerline fonts
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts

    # Setup Yabai scripting-addition (only works if SIP is disabled)
    # sudo yabai --install-sa
    # brew services start koekeishiya/formulae/yabai
    # brew services start koekeishiya/formulae/skhd
fi

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim +PluginInstall +qall

# Install Haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Manual steps
# Update iTerm2 > Profile > Command to /usr/local/bin/fish
# Change Caps Lock to Escape in OSX Keyboard > Modifier Keys (far bottom right)
# chrome://version copy Profile Path
# Copy ~/.local/share/fish for fish_history (similar for fzf etc)
