#!/usr/bin/env bash

# pipefail matters for the `curl … | sh` installers below: without it only the
# last command's status counts, so a failed download still looks like success.
set -euo pipefail

# fedora-copr.txt, fedora-packages.txt, Brewfile and ./fonts/
# are all read relative to the repo, so anchor to the script rather than the
# caller's working directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

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

    # dotnet must land before the `dotnet tool update` step further down. On
    # Fedora it arrives with the dnf packages; macOS has no such package, so it
    # is bootstrapped here rather than in the macOS section at the end.
    # if ! command -v dotnet >/dev/null 2>&1; then
    #     curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version latest
    # fi
fi

if command -v dnf &> /dev/null; then
    # Enable copr repos first — some packages below are served from them.
    # `sed 's/#.*//'` strips inline/standalone comments; word-splitting drops blanks.
    # shellcheck disable=SC2013  # word-splitting is intended: one repo per word
    for repo in $(sed 's/#.*//' fedora-copr.txt); do
        sudo dnf copr enable -y "$repo"
    done
    # shellcheck disable=SC2046  # word-splitting is intended: one argument per package
    sudo dnf install -y $(sed 's/#.*//' fedora-packages.txt)
elif command -v brew &> /dev/null; then
    brew bundle install
fi

# Create the theme target directory BEFORE stow runs. stow folds an entire
# package subtree into one symlink when the target directory doesn't exist yet,
# so on a fresh machine ~/.config/gtk-4.0 would become a link into the repo —
# and the Dracula symlinks further down would then write inside the repo.
mkdir -p ~/.config/gtk-4.0

# Setup dotfiles. stow aborts on the first conflict, so on a machine that
# already has real config files in place you would otherwise discover them one
# failed run at a time. Dry-run everything first and report the whole list.
STOW_PACKAGES=()
for dir in */; do
    STOW_PACKAGES+=("${dir%/}")
done

if ! conflicts=$(stow -n -t ~/ -S "${STOW_PACKAGES[@]}" 2>&1); then
    echo "stow: existing files block these links. Move or delete them, then re-run:" >&2
    echo "$conflicts" >&2
    exit 1
fi

stow -v -t ~/ -S "${STOW_PACKAGES[@]}"

# Setup fish
FISH_PATH=$(command -v fish)

# Add fish to list of shells
if ! grep -q "^$FISH_PATH\$" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

# Set fish as default. Guarded because chsh prompts for a password on macOS —
# unguarded it would block every re-run even with nothing to change.
if [ "${SHELL:-}" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
fi

export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
if ! command -v mise >/dev/null 2>&1; then
    curl https://mise.run | sh
fi

# Install languages and tools from global config
mise install

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

# Install OCaml (opam already installed by mise)
if [ ! -d "$HOME/.opam" ]; then
    opam init -y --disable-sandboxing
fi
opam install -y dune ocaml-lsp-server ocamlformat utop

# Install F# LSP. `tool update` installs when absent and upgrades when present;
# `tool install` exits 1 on an already-installed tool, aborting the script.
# dotnet itself comes from dnf on Fedora (fedora-packages.txt) and from the
# dotnet-install.sh in the macOS block below.
# dotnet tool update --global fsautocomplete

# Haskell (ghc + hls) is provisioned by ghcup's postinstall in mise's config.toml,
# so `mise install` above has already handled it.

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

    # Targets for the font/theme/binary installs below.
    mkdir -p ~/.local/share/fonts ~/.themes ~/.icons "$LOCAL_BIN/bin"

    clone_or_update https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git \
        "$TMPROOT/SFMono"
    cp "$TMPROOT"/SFMono/*.otf ~/.local/share/fonts

    # Downloads and unpacking stay inside TMPROOT so the repo never collects
    # artefacts. `wget -O` overwrites rather than writing a .1 suffix on a
    # re-run, and `7z -y` answers the overwrite prompt that would otherwise
    # block an unattended run.
    wget -O "$TMPROOT/MapleMono-NF.zip" \
        https://github.com/subframe7536/maple-font/releases/download/v7.7/MapleMono-NF.zip
    7z x -y -o"$TMPROOT/maple" "$TMPROOT/MapleMono-NF.zip"
    cp "$TMPROOT"/maple/Maple*.ttf ~/.local/share/fonts


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
    sudo dnf group install -y multimedia
    # https://rpmfusion.org/Configuration/
    sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
    sudo dnf install -y ffmpeg --allowerasing
    # https://github.com/devangshekhawat/Fedora-41-Post-Install-Guide
    
    # Audio setup
    # https://wiki.linuxaudio.org/wiki/system_configuration#limitsconfaudioconf
    
    # Install LOVR — download straight to its destination, no intermediate file.
    wget -O "$LOCAL_BIN/bin/lovr" https://lovr.org/f/lovr-x86_64.AppImage
    chmod a+x "$LOCAL_BIN/bin/lovr"

    # Install Gnome theme
    # https://draculatheme.com/gtk
    # https://github.com/odziom91/libadwaita-theme-changer/blob/main/libadwaita-tc.py
    # `rm -rf` before each `mv`: moving onto an existing directory nests a second
    # copy inside it (~/.themes/Dracula/gtk-master) rather than failing, so a
    # re-run would silently corrupt the theme. `ln -sfn` replaces the existing
    # links instead of erroring; -n stops -f dereferencing a link to a directory
    # and creating the new link underneath it.
    wget -O "$TMPROOT/dracula-gtk.zip" https://github.com/dracula/gtk/archive/master.zip
    7z x -y -o"$TMPROOT/dracula-gtk" "$TMPROOT/dracula-gtk.zip"
    rm -rf ~/.themes/Dracula
    mv "$TMPROOT/dracula-gtk/gtk-master" ~/.themes/Dracula
    ln -sfn ~/.themes/Dracula/assets ~/.config/assets
    ln -sfn ~/.themes/Dracula/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
    ln -sfn ~/.themes/Dracula/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
    ln -sfn ~/.themes/Dracula/gtk-4.0/assets ~/.config/gtk-4.0/assets
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

    wget -O "$TMPROOT/dracula-icons.zip" https://github.com/dracula/gtk/files/5214870/Dracula.zip
    7z x -y -o"$TMPROOT/dracula-icons" "$TMPROOT/dracula-icons.zip"
    rm -rf ~/.icons/Dracula
    mv "$TMPROOT/dracula-icons/Dracula" ~/.icons/Dracula
    gsettings set org.gnome.desktop.interface icon-theme "Dracula"

    # Default apps: open images in loupe instead of letting the browser grab them
    xdg-mime default org.gnome.Loupe.desktop image/png image/jpeg image/gif image/webp image/bmp image/tiff image/svg+xml image/x-icon image/heif image/avif image/x-portable-pixmap

    # swaync runs via exec-once in hyprland.conf; mask its bus-activated systemd unit so it
    # doesn't double-start and flap once graphical-session.target is active.
    systemctl --user mask swaync.service

    # Socket-activated ssh-agent at a fixed path under $XDG_RUNTIME_DIR.
    # config.fish points SSH_AUTH_SOCK at it; nothing else spawns an agent.
    systemctl --user enable ssh-agent.socket

    # Fix Houdini App switcher icon under X
    # echo "StartupWMClass=Houdini FX" | sudo tee -a /usr/share/applications/com.sidefx.houdini*.desktop
   
    # Desktop Shell
    # mkdir -p ~/.config/quickshell/noctalia-shell && \
    # curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | \
    # tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell

    # Theme for fcitx
    clone_or_update https://github.com/drbbr/fcitx5-dracula-theme.git \
        ~/.local/share/fcitx5/themes/dracula

fi

# Setup Mac
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    brew bundle install --file=Brewfile.macos

    # Increase OSX Dock animation speed
    defaults write com.apple.dock autohide-time-modifier -float 0.2
    # killall exits non-zero when nothing matches, which would abort under set -e.
    killall Dock || true

    # brew services start koekeishiya/formulae/yabai
    # brew services start koekeishiya/formulae/skhd

    # k9s doesn't read from .config on OSX...
    ln -sfn ~/.config/k9s ~/Library/Application\ Support/k9s

    # Ruff also doesn't
    ln -sfn ~/.config/ruff ~/Library/Application\ Support/ruff

    # Manual steps
    # Change Caps Lock to Escape in OSX Keyboard > Modifier Keys (far bottom right)
    # chrome://version copy Profile Path
    # Copy ~/.local/share/fish for fish_history (similar for fzf etc)
fi

# if [[ $(uname -a) =~ ^WSL.* ]]; then
    # Under WSL, win32yank is needed to make clipboard paste work as expected in vim
    # TODO: this is now only needed on the Windows side?
    # curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    # unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    # chmod +x /tmp/win32yank.exe
    # sudo mv /tmp/win32yank.exe /usr/local/bin/

    # Install dotnet
    # sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
# fi

# Firefox settings
# widget.wayland.fractional-scale.enabled = false # fix extension scaling weirdness on hyprland
#
#
