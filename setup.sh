#!/usr/bin/env bash

set -e

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
	echo "Mac"
else
	test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
	test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
	echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
	sudo apt-get install build-essential
    sudo apt-get install libreadline-dev  # For better fennel repl support
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
if ! grep fish_user_paths ~/.config/fish/config.fish; then
	echo 'set -U fish_user_paths (brew --prefix)/bin/ $fish_user_paths' >>~/.config/fish/config.fish
fi

fish -c fish_update_completions

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

	# k9s doesn't read from .config on OSX...
	ln -s ~/.config/k9s/ ~/Library/Application\ Support/k9s

	# Install dotnet
	curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version latest
fi

if [[ $(uname -a) =~ ^WSL.* ]]; then
	# Under WSL, win32yank is needed to make clipboard paste work as expected in vim
	# TODO: this is now only needed on the Windows side?
	# curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
	# unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
	# chmod +x /tmp/win32yank.exe
	# sudo mv /tmp/win32yank.exe /usr/local/bin/

	# Install dotnet
	sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0

fi

pip3 install -r requirements.txt

npm install -g typescript-language-server graphql-language-service-cli graphql typescript neovim bash-language-server @vscode/codicons vscode-langservers-extracted

# Install Fennel
luarocks --local install fennel
luarocks --local install readline

# Install Fennel LSP
git clone https://git.sr.ht/~xerool/fennel-ls
cd fennel-ls
make && make install PREFIX=$HOME
cd -
rm -rf fennel-ls

# Install Haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Install Haskell LSP
ghcup install hls

# Install Rust
curl https://sh.rustup.rs -sSf | sh

# Install WGSL LSP
cargo install --git https://github.com/wgsl-analyzer/wgsl-analyzer wgsl_analyzer

# Install OCaml
opam init -y --disable-sandboxing 
opam install dune ocaml-lsp-server ocamlformat utop

# Install F# LSP
dotnet tool install --global fsautocomplete

# Install GLSL Analyzer
wget https://github.com/nolanderc/glsl_analyzer/releases/download/v1.4.4/x86_64-linux-musl.zip
unzip x86_64-linux-musl.zip

# Install debuggers
VENVPATH=~/.virtualenvs
python3 -m venv $VENVPATH/debugpy
$VENVPATH/debugpy/bin/pip install debugpy

# Manual steps
# Update iTerm2 > Profile > Command to /usr/local/bin/fish
# Change Caps Lock to Escape in OSX Keyboard > Modifier Keys (far bottom right)
# chrome://version copy Profile Path
# Copy ~/.local/share/fish for fish_history (similar for fzf etc)
