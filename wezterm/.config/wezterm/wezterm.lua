local wezterm = require 'wezterm'
local act = wezterm.action

-- Send the tmux prefix (C-a) then <key>, so tmux commands become single
-- "prefixless" Alt chords. (Pattern from joshmedeski/dotfiles-wezterm.)
local function tmux(key)
    return act.Multiple {
        act.SendKey { mods = 'CTRL', key = 'a' },
        act.SendKey { key = key },
    }
end


local default_domain = 'local'
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_domain = 'WSL:Ubuntu-22.04'
    -- default_prog = { "C:\\Windows\\System32\\wsl.exe ~"},
end

local min_opacity = 0.0
wezterm.on('toggle-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = min_opacity
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end)

wezterm.on('update-right-status', function(window, pane)
    local workspace = window:active_workspace()
    if workspace == "default" then
        window:set_right_status('')
        return
    end
    window:set_right_status(' ' .. workspace .. ' ')
end)

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- If the tab title is explicitly set, use that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active tab pane
    return tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local title = tab_title(tab)
        return ' ' .. tab.tab_index + 1 .. ' ' .. title .. ' '
    end
)

return {
    default_domain = default_domain,
    front_end = 'WebGpu',
    check_for_updates = false,
    color_scheme = 'Oxocarbon Dark',
    -- enable_wayland = false,
    -- color_scheme = "Catppuccin Mocha",
    -- color_scheme = "Operator Mono Dark",
    colors = {
        tab_bar = {
            background = 'None',
            active_tab = {
                fg_color = 'white',
                bg_color = 'None',
                intensity = 'Bold',
            },
            inactive_tab = {
                fg_color = '#444444',
                bg_color = 'None',
            },
        },
    },
    macos_window_background_blur = 75,
    enable_tab_bar = false,
    -- enable_tab_bar = true,
    -- use_fancy_tab_bar = false,
    -- tab_bar_at_bottom = true,
    show_new_tab_button_in_tab_bar = false,
    use_dead_keys = false,
    -- native_macos_fullscreen_mode = false,
    -- RESIZE doesn't play well with hyprland but it's not needed
    window_decorations = wezterm.target_triple == 'x86_64-unknown-linux-gnu' and 'NONE' or 'RESIZE',
    window_background_opacity = 0.85,
    window_padding = {
        left = 24,
        right = 24,
        top = 24,
        bottom = 24,
    },
    -- initial_rows = 50,
    -- initial_cols = 200,

    font = wezterm.font('Liga SFMono Nerd Font'),
    -- font = wezterm.font('JetBrainsMono NF'),
    -- font = wezterm.font('JetBrains Mono'),
    -- font = wezterm.font('Cascadia Code NF'),
    -- font = wezterm.font('SpaceMono NF'),
    -- font = wezterm.font('Fira Code'),
    -- font = wezterm.font('FiraCode Nerd Font'),
    -- font = wezterm.font('VictorMono NF', { weight = 'Bold'}),
    -- font = wezterm.font('Maple Mono NF'),
    font_rules = {
        {
            intensity = 'Bold',
            italic = true,
            font = wezterm.font('Maple Mono NF', { weight = 'Bold', style = "Italic" }),
        },
        {
            intensity = 'Half',
            italic = true,
            font = wezterm.font('Maple Mono NF', { weight = "DemiBold", style = "Italic" }),
        },
        {
            intensity = 'Normal',
            italic = true,
            font = wezterm.font('Maple Mono NF', { style = "Italic" }),
        },
    },
    font_size = 15,
    line_height = 1.4,
    cell_width = 0.9,

    -- On Mac, command is the super key
    leader = { key = ' ', mods = 'CTRL' },
    keys = {
        -- Wezterm-native nicety kept on the leader; tmux owns everything else.
        {
            key = 'Enter',
            mods = 'LEADER',
            -- action = wezterm.action.ToggleFullScreen,
            action = wezterm.action.EmitEvent 'toggle-opacity'
        },

        -- Prefixless tmux layer: Alt+<key> injects `C-b <key>`. tmux is the sole
        -- multiplexer; Wezterm's own panes/workspaces are retired in its favour.
        -- Concentric hjkl nav: Ctrl=nvim splits, Alt=tmux panes, Alt+Shift=tmux sessions, Super=Hyprland.
        { key = 'h', mods = 'ALT', action = tmux 'h' }, -- pane left
        { key = 'j', mods = 'ALT', action = tmux 'j' }, -- pane down
        { key = 'k', mods = 'ALT', action = tmux 'k' }, -- pane up
        { key = 'l', mods = 'ALT', action = tmux 'l' }, -- pane right

        { key = 'v', mods = 'ALT', action = tmux 'v' }, -- split side-by-side
        { key = 's', mods = 'ALT', action = tmux 's' }, -- split stacked
        { key = 'w', mods = 'ALT', action = tmux 'x' }, -- kill pane
        { key = 'z', mods = 'ALT', action = tmux 'z' }, -- zoom pane toggle
        { key = '[', mods = 'ALT', action = tmux '[' }, -- copy mode

        { key = 't', mods = 'ALT', action = tmux 'c' }, -- new window
        { key = 'n', mods = 'ALT', action = tmux 'n' }, -- next window
        { key = 'p', mods = 'ALT', action = tmux 'p' }, -- prev window
        { key = 'n', mods = 'ALT|SHIFT', action = tmux ')' }, -- next session (tmux native ))
        { key = 'p', mods = 'ALT|SHIFT', action = tmux '(' }, -- prev session (tmux native ()
        { key = 'Tab', mods = 'ALT', action = tmux 'n' }, -- next window
        { key = 'Tab', mods = 'ALT|SHIFT', action = tmux 'p' }, -- prev window
        { key = ' ', mods = 'ALT', action = tmux 'w' }, -- window/session tree
        { key = 'r', mods = 'ALT', action = tmux 'r' }, -- rename window
        { key = 'r', mods = 'ALT|SHIFT', action = tmux '$' }, -- rename session (tmux native $)
        { key = 'o', mods = 'ALT', action = tmux 'f' }, -- sessionizer (mirrors Super+O)

        { key = '1', mods = 'ALT', action = tmux '1' },
        { key = '2', mods = 'ALT', action = tmux '2' },
        { key = '3', mods = 'ALT', action = tmux '3' },
        { key = '4', mods = 'ALT', action = tmux '4' },
        { key = '5', mods = 'ALT', action = tmux '5' },
        { key = '6', mods = 'ALT', action = tmux '6' },
        { key = '7', mods = 'ALT', action = tmux '7' },
        { key = '8', mods = 'ALT', action = tmux '8' },
        { key = '9', mods = 'ALT', action = tmux '9' },

        -- Fix Arrow Keys within WSL only
        -- { key = 'UpArrow', action = wezterm.action { SendString = '\x1b[A' } },
        -- { key = 'DownArrow', action = wezterm.action { SendString = '\x1b[B' } },
    }
}
