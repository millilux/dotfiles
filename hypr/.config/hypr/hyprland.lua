require("keybinds")

--------------
--- NVIDIA ---
--------------
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")   -- nvidia-vaapi-driver: use the modern DRM/PRIME backend (no EGL), better on Wayland
-- NOTE: VA-API HW video decode works here (verified with `mpv --hwdec=vaapi-copy` -> "Using hardware decoding").
-- Don't trust nvtop's DEC gauge / nvidia-smi "Decoder %" on this RTX 4080 (Ada) — NVML under-reports decode util,
-- so it reads 0% even mid-decode. Confirm via the app instead (mpv log, Firefox MOZ_LOG, chrome://media-internals).

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

----------------
--- MONITORS ---
----------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.5,
})

-- Mitigate mixed DPI issues with XWayland apps.
-- You'll need to scale via platform specific settings to get back to the desired size.
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-----------------
--- AUTOSTART ---
-----------------
-- Bring up a systemd session so xdg-desktop-portal starts (fixes Flatpak dark theme,
-- file pickers, screenshare). dbus line ensures portals spawn with the Wayland socket.
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    -- hl.exec_cmd("nm-applet &")
    hl.exec_cmd("waybar & hyprpaper")
    hl.exec_cmd("swaync")
    hl.exec_cmd("/usr/libexec/polkit-mate-authentication-agent-1")
    hl.exec_cmd("fcitx5")
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_SCALE_FACTOR", "1.5")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland")
hl.env("GDK_SCALE", "2")
hl.env("GDK_GL", "gles")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("EDITOR", "nvim")
hl.env("MOZ_ENABLE_WAYLAND", "1")
-- hl.env("LC_CTYPE", "ja")
-- hl.env("FC_LANG", "ja")
-- hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

hl.on("hyprland.start", function()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Dracula"')   -- for GTK3 apps
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')   -- for GTK4 apps
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"')
    hl.exec_cmd('gsettings set org.gnome.desktop.wm.preferences button-layout ":close"')
end)
-- hl.env("GTK_THEME", "Tokyonight-Dark")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")   -- Qt apps  follow the GTK/Dracula dark theme
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

---------------------
--- LOOK AND FEEL ---
---------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,

        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "master",

        -- snap = {
        --     enabled = true,
        -- },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#decoration
hl.config({
    decoration = {
        rounding = 14,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled = false,
            range = 12,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 3,
            passes = 3,
            popups = true,
        },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#animations
hl.config({
    animations = {
        enabled = true,
    },
})

-- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#misc
hl.config({
    misc = {
        disable_hyprland_logo = true,
        enable_anr_dialog = false,
        focus_on_activate = false,
        force_default_wallpaper = 0,
    },
})

hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0.1 })

-- Be sure that the background colors in sway have an alpha greater than 0
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, ignore_alpha = 0.1 })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, ignore_alpha = 0.1 })

-------------
--- INPUT ---
-------------
-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "gb",
        -- kb_options = "caps:swapescape", -- Handled in keyboard config for now.
        -- kb_variant = "",
        kb_model = "",
        kb_rules = "",
        repeat_delay = 200,
        repeat_rate = 80,

        follow_mouse = 2,
        float_switch_override_focus = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------
-- https://wiki.hyprland.org/Configuring/Window-Rules/
-- https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- hl.window_rule({ match = { class = ".*" }, float = true })
-- hl.window_rule({ match = { float = true, workspace = "s[true]" }, border_size = 0 })
hl.window_rule({ match = { workspace = 3 }, float = true })
hl.window_rule({ match = { title = "^(fsearch|Calculator|Qalculate|Preferences)$" }, float = true })

hl.window_rule({ match = { class = "org.gnome.Nautilus" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, center = true })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, size = { "monitor_w*0.6", "monitor_h*0.6" } })

hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, float = true })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, size = { "monitor_w*0.3", "monitor_h*0.6" } })

hl.window_rule({ match = { class = "^(imv)$" }, float = true })
hl.window_rule({ match = { class = "^(imv)$" }, size = { "monitor_w*0.7", "monitor_h*0.7" } })
hl.window_rule({ match = { class = "^(imv)$" }, center = true })

hl.window_rule({ match = { class = "gcr-prompter" }, float = true })

hl.window_rule({ match = { class = "^(org.tildearrow.furnace|com.bitwig.BitwigStudi|dev.zed.Zed)" }, fullscreen = true })
hl.window_rule({ match = { title = "Renoise \\(x86_64\\)" }, fullscreen = true })

-- hl.window_rule({ match = { class = "^(org.wezfurlong.wezterm|kitty)$" }, workspace = "1" })
hl.window_rule({ match = { title = "^(WorkFlowy)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^(Houdini FX|houdini_launcher|blender|Renoise|com.bitwig.BitwigStudi|org.tildearrow.furnace|dev.zed.Zed)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(mpv|harmonoid|org.gnome.Rhythmbox3|ColinDuquesnoy.gitlab.com.MellowPlayer)" }, workspace = "5" })
hl.window_rule({ match = { class = "org.gnome.Calendar" }, workspace = "7" })
hl.window_rule({ match = { class = "com.discordapp.Discord" }, workspace = "8" })
hl.window_rule({ match = { class = "Vivaldi-flatpak" }, workspace = "9" })
hl.window_rule({ match = { class = "org.mozilla.firefox" }, workspace = "10" })

hl.window_rule({ match = { workspace = "special:magic" }, float = true })

-- Ignore maximize requests from apps. You'll probably like this.
-- hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Trying to get firefox fullscreen within a window. Hyprland's old "fakefullscreen"
-- hl.window_rule({ match = { class = ".org.mozilla.firefox" }, fullscreen_state = "1" })
-- hl.window_rule({ match = { class = "(firefox)" }, sync_fullscreen = false })
