#!/usr/bin/env bash

set -e

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    echo "Mac"
else
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    sudo apt-get install build-essential
fi

brew bundle install

# Setup dotfiles
for dir in */; do
    stow -v -t ~/ -S $dir
done

# Add fish to list of shells
if ! grep fish /etc/shells; then
    echo $(which fish) | sudo tee -a /etc/shells
fi

# Set fish as default
chsh -s $(which fish)

# Add homebrew path to fish config
echo 'set -U fish_user_paths (brew --prefix)/bin/ $fish_user_paths' >> ~/.config/fish/config.fish

fish -c fish_update_completions

# Install fisher
# curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    brew bundle install --file=Brewfile.macos

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

pip install -r requirements.txt

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

# Install Haskell
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Manual steps
# Update iTerm2 > Profile > Command to /usr/local/bin/fish
# Change Caps Lock to Escape in OSX Keyboard > Modifier Keys (far bottom right)
# chrome://version copy Profile Path
# Copy ~/.local/share/fish for fish_history (similar for fzf etc)
