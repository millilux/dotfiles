#!/usr/bin/env bash

set -e

LOCAL_BIN=$HOME/.local

# Scratch space for source builds. The trap fires on every exit path — success,
# failure, Ctrl-C — so a failed build never leaves a tree behind to wedge the
# next run.
TMPROOT=$(mktemp -d)
trap 'rm -rf "$TMPROOT"' EXIT

# Build a source tree and install into $LOCAL_BIN. `make -C` keeps the working
# directory untouched, so these are position-independent and re-runnable.
build_from_source() {
    local url=$1 name=$2
    git clone --depth=1 "$url" "$TMPROOT/$name"
    make -C "$TMPROOT/$name"
    make -C "$TMPROOT/$name" install PREFIX="$LOCAL_BIN"
}

# Clone to a fixed location, or fast-forward it when already present.
clone_or_update() {
    local url=$1 dest=$2
    if [ -d "$dest/.git" ]; then
        git -C "$dest" pull --ff-only
    else
        git clone --depth=1 "$url" "$dest"
    fi
}

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    # Command Line Tools supply clang and make, which the source builds below and
    # nvim-treesitter's parser compilation both need.
    xcode-select -p >/dev/null 2>&1 || xcode-select --install

    # Homebrew is Mac-only here: it owns GUI casks and Mac-native formulae.
    # On Linux that role belongs to dnf, and portable CLI tools come from mise.
    if ! command -v brew >/dev/null 2>&1; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
fi

if command -v dnf &> /dev/null; then
    # Enable copr repos first — some packages below are served from them.
    # `sed 's/#.*//'` strips inline/standalone comments; word-splitting drops blanks.
    for repo in $(sed 's/#.*//' fedora-copr.txt); do
        sudo dnf copr enable -y "$repo"
    done
    # shellcheck disable=SC2046  # word-splitting is intended: one argument per package
    sudo dnf install -y $(sed 's/#.*//' fedora-packages.txt)
elif command -v brew &> /dev/null; then
    brew bundle install
fi

# Setup dotfiles
for dir in */; do
    stow -v -t ~/ -S "$dir"
done

# Setup fish
# Add fish to list of shells
if ! grep fish /etc/shells; then
    which fish | sudo tee -a /etc/shells
fi

# Set fish as default
chsh -s "$(which fish)"

# config.fish adds the brew prefix to PATH itself, guarded on brew existing.

# Install mise
curl https://mise.run | sh
# Install languages and tools from global config
mise install

# Runtimes + most LSPs/formatters/linters are declared in
# mise/.config/mise/config.toml (npm:/pipx:/ubi:/aqua: backends) and installed
# by `mise install` above — one cross-platform source of truth.

# pylsp is the exception: its plugins must share ONE venv, which pipx/mise can't
# express, so install it with uv (uv is a mise-managed tool).
uv tool install python-lsp-server \
    --with pyls-isort --with pylsp-mypy --with python-lsp-ruff --with pylsp-rope

# Neovim's Python provider libs must live in the interpreter nvim calls as its
# python3 host — kept in requirements.txt (now trimmed to provider-only).
pip3 install -r requirements.txt

# Install Fennel
# luarocks --local install fennel
# luarocks --local install readline

# Lua LSP addons — type definitions lua-language-server reads in place.
clone_or_update https://github.com/LuaCATS/love2d.git \
    "$HOME/.local/share/lua-lsp-addons/love2d"

# fennel-ls and fnlfmt are sr.ht projects with no release binaries, so they are
# the only tools still built from source. Both are pure Lua: `make install`
# copies files, no compiler involved.
build_from_source https://git.sr.ht/~xerool/fennel-ls fennel-ls
build_from_source https://git.sr.ht/~technomancy/fnlfmt fnlfmt

# clangd, glsl_analyzer and wgsl-analyzer come from mise (ubi: backend, prebuilt
# release binaries). See mise config.toml.

# Install Rust
# curl https://sh.rustup.rs -sSf | sh
# rust-analyzer now via mise (aqua:rust-lang/rust-analyzer)

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

# Turn off Go telemetry
go telemetry off

# Install yazi flavors/plugins from the tracked package.toml manifest.
# Only package.toml is version-controlled (flavors/ is gitignored), so this
# materialises the pinned flavor on a fresh machine. Use `ya pkg add` to add a
# NEW dependency; use `ya pkg upgrade` to bump the pins.
ya pkg install

fish -c fish_update_completions

if [ -f /etc/os-release ] && grep -q "Fedora" /etc/os-release; then
    # Install eww
    # git clone https://github.com/elkowar/eww
    # cd eww
    # cargo build --release --no-default-features --features=wayland
    # mv target/release/eww $LOCAL_BIN/bin/
    # chmod +x $LOCAL_BIN/bin/eww

    clone_or_update https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git \
        "$TMPROOT/SFMono"
    cp "$TMPROOT"/SFMono/*.otf ~/.local/share/fonts

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
    sudo dnf install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
    sudo dnf install ffmpeg --allowerasing
    # https://github.com/devangshekhawat/Fedora-41-Post-Install-Guide
    
    # Audio setup
    # https://wiki.linuxaudio.org/wiki/system_configuration#limitsconfaudioconf
    
    # Install LOVR
    image=lovr-x86_64.AppImage
    wget "https://lovr.org/f/$image"
    mv "$image" "$LOCAL_BIN/bin/lovr"
    chmod a+x "$LOCAL_BIN/bin/lovr"

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

    # Default apps: open images in loupe instead of letting the browser grab them
    xdg-mime default org.gnome.Loupe.desktop image/png image/jpeg image/gif image/webp image/bmp image/tiff image/svg+xml image/x-icon image/heif image/avif image/x-portable-pixmap

    # swaync runs via exec-once in hyprland.conf; mask its bus-activated systemd unit so it
    # doesn't double-start and flap once graphical-session.target is active.
    systemctl --user mask swaync.service

    # Fix Houdini App switcher icon under X
    # echo "StartupWMClass=Houdini FX" | sudo tee -a /usr/share/applications/com.sidefx.houdini*.desktop
   
    # Desktop Shell
    mkdir -p ~/.config/quickshell/noctalia-shell && \
    curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | \
    tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell

    # Theme for fcitx
    clone_or_update https://github.com/drbbr/fcitx5-dracula-theme.git \
        ~/.local/share/fcitx5/themes/dracula

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

# Firefox settings
# widget.wayland.fractional-scale.enabled = false # fix extension scaling weirdness on hyprland
#
#
