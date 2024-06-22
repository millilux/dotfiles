local wezterm = require 'wezterm'
local act = wezterm.action

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

return {
    default_domain = default_domain,
    check_for_updates = false,
    color_scheme = 'Oxocarbon Dark',
    -- color_scheme = "Catppuccin Mocha",
    -- color_scheme = "Operator Mono Dark",
    macos_window_background_blur = 100,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
    use_dead_keys = false,
    window_decorations = 'RESIZE',
    window_background_opacity = 0.85,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    initial_rows = 50,
    initial_cols = 200,

    font = wezterm.font('Liga SFMono Nerd Font'),
    --   font = wezterm.font('JetBrains Mono'),
    --   font = wezterm.font('SpaceMono NF'),
    --   font = wezterm.font('VictorMono NF', { weight = 'Bold'}),
    font_size = 15,
    line_height = 1.4,
    cell_width = 0.9,

    leader = { key = ' ', mods = 'CTRL' },
    keys = {
        {
            key = 'Enter',
            mods = 'LEADER',
            -- action = wezterm.action.ToggleFullScreen,
            action = wezterm.action.EmitEvent 'toggle-opacity'
        },
        {
            key = 'w',
            mods = 'LEADER',
            action = act.CloseCurrentPane { confirm = false },
        },
        {
            key = 'v',
            mods = 'LEADER',
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = 's',
            mods = 'LEADER',
            action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'h',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Left',
        },
        {
            key = 'l',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Right',
        },
        {
            key = 'k',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Up',
        },
        {
            key = 'j',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Down',
        },
        {
            key = 'r',
            mods = 'LEADER',
            action = act.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(function(window, pane, line)
                    -- line will be `nil` if they hit escape without entering anything
                    -- An empty string if they just hit enter
                    -- Or the actual line of text they wrote
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },
        -- Fix Arrow Keys within WSL
        { key = 'UpArrow', action = wezterm.action { SendString = '\x1b[A' } },
        { key = 'DownArrow', action = wezterm.action { SendString = '\x1b[B' } },
    }
}
