#!/usr/bin/env bash

set -e

LOCAL_BIN=$HOME/.local

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    echo "Mac"
else
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
    # sudo apt-get install build-essential
    # sudo apt-get install libreadline-dev # For better fennel repl support
fi

if command -v dnf &> /dev/null; then
    sudo dnf install $(cat fedora-packages.txt)
elif command -v brew &> /dev/null; then
    # TODO: only use brew on Mac and WSL
    brew bundle install
fi

# Setup dotfiles
for dir in */; do
    stow -v -t ~/ -S $dir
done

# Setup fish
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

# Install mise
curl https://mise.run | sh
# Install languages and tools from global config
mise install

mise use python
pip3 install -r requirements.txt

npm install -g typescript-language-server graphql-language-service-cli graphql typescript neovim bash-language-server @vscode/codicons vscode-langservers-extracted prettier yaml-language-server

# Install Fennel
# luarocks --local install fennel
# luarocks --local install readline

# Install Lua LSP Addons
addons_dir=~/.local/share/lua-lsp-addons
mkdir -p $addons_dir
cd $addons_dir
git clone https://github.com/LuaCATS/love2d.git
cd -

# Install Fennel LSP
git clone https://git.sr.ht/~xerool/fennel-ls
cd fennel-ls
make && make install PREFIX=$LOCAL_BIN
cd -
rm -rf fennel-ls

# Install Fennel Format
git clone https://git.sr.ht/~technomancy/fnlfmt
cd fnlfmt
make && make install PREFIX=$LOCAL_BIN
cd -
rm -rf fnlfmt

# Install ccls
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -S. -BRelease
mv ccls ~/bin/
# make && make install PREFIX=$HOME

# Install GLSL Analyzer
git clone https://github.com/nolanderc/glsl_analyzer.git
cd glsl_analyzer
zig build install -Doptimize=ReleaseSafe --prefix $LOCAL_BIN
rm -rf glsl_analyzer

# Install Rust
# curl https://sh.rustup.rs -sSf | sh
# rustup component add rust-analyzer

# Install OCaml (opam already installed by mise)
opam init -y --disable-sandboxing
opam install dune ocaml-lsp-server ocamlformat utop

# Install F# LSP (dotnet already installed by mise)
dotnet tool install --global fsautocomplete

# Install Haskell LSP (ghcup already installed by mise)
ghcup install ghc
ghcup install hls
ghcup set ghc
ghcup set hls

# Install WGSL LSP
cargo install --git https://github.com/wgsl-analyzer/wgsl-analyzer wgsl_analyzer

# Turn off Go telemetry
go telemetry off

fish -c fish_update_completions

if [ -f /etc/os-release ] && grep -q "Fedora" /etc/os-release; then
    # Install eww
    # git clone https://github.com/elkowar/eww
    # cd eww
    # cargo build --release --no-default-features --features=wayland
    # mv target/release/eww $LOCAL_BIN/bin/
    # chmod +x $LOCAL_BIN/bin/eww

    git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git && cd SFMono-Nerd-Font-Ligaturized
    cp *.otf ~/.local/share/fonts

    wget https://github.com/subframe7536/maple-font/releases/download/v7.7/MapleMono-NF.zip
    7z x MapleMono-NF.zip
    mv Maple*.ttf ~/.local/share/fonts

    cp ./fonts/05-language-fallback.conf /etc/fonts/conf.d/

    # Set screen resolution in kernel rather than userspace
    # sudo grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
    # /etc/default/grub

    # Make SDDM default
    sudo systemctl enable sddm.service -f
    # Edit config 
    # sudo nvim /usr/share/sddm/themes/breeze/theme.conf.user
    # [General]
    # background=/usr/share/backgrounds/fedora-workstation/montclair_dark.webp
    # Set theme
    # sudo nvim /etc/sddm.conf.d/custom.conf
    # [Theme]
    # Current=breeze

    # Install multimedia codecs
    sudo dnf group install multimedia
    # https://rpmfusion.org/Configuration/
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
    sudo dnf install ffmpeg --allowerasing
    # https://github.com/devangshekhawat/Fedora-41-Post-Install-Guide
    
    # Audio setup
    # https://wiki.linuxaudio.org/wiki/system_configuration#limitsconfaudioconf
    
    # Install LOVR
    image=lovr-x86_64.AppImage
    wget https://lovr.org/f/$image
    mv $image $LOCAL_BIN/bin/lovr
    chmod a+x $LOCAL_BIN/bin/lovr

    # Install Gnome theme
    # https://draculatheme.com/gtk
    # https://github.com/odziom91/libadwaita-theme-changer/blob/main/libadwaita-tc.py
    wget https://github.com/dracula/gtk/archive/master.zip
    7z x master.zip
    rm master.zip
    mv gtk-master ~/.themes/Dracula
    ln -s ~/.themes/Dracula/assets/ ~/.config/assets
    ln -s ~/.themes/Dracula/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
    ln -s ~/.themes/Dracula/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
    ln -s ~/.themes/Dracula/gtk-4.0/assets ~/.config/gtk-4.0/assets
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

    wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
    7z x Dracula.zip 
    rm Dracula.zip
    mv Dracula/ ~/.icons/
    gsettings set org.gnome.desktop.interface icon-theme "Dracula"

    # Fix Houdini App switcher icon under X
    # echo "StartupWMClass=Houdini FX" | sudo tee -a /usr/share/applications/com.sidefx.houdini*.desktop
fi

# Setup Mac
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    brew bundle install --file=Brewfile.macos

    # Increase OSX Dock animation speed
    defaults write com.apple.dock autohide-time-modifier -float 0.2
    killall Dock

    # Setup Yabai scripting-addition (only works if SIP is disabled)
    # sudo yabai --install-sa
    # brew services start koekeishiya/formulae/yabai
    # brew services start koekeishiya/formulae/skhd

    # k9s doesn't read from .config on OSX...
    ln -s ~/.config/k9s/ ~/Library/Application\ Support/k9s

    # Ruff also doesn't
    ln -s ~/.config/ruff/ ~/Library/Application\ Support/ruff

    # Install dotnet
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version latest

    # Manual steps
    # Change Caps Lock to Escape in OSX Keyboard > Modifier Keys (far bottom right)
    # chrome://version copy Profile Path
    # Copy ~/.local/share/fish for fish_history (similar for fzf etc)
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
