local wezterm = require 'wezterm'
local act = wezterm.action

return {
    line_height = 1.2,
    -- enable_tab_bar = false,
    -- use_fancy_tab_bar = false,
    font_size = 14,
    -- color_scheme = "Catppuccin Mocha",
    color_scheme = "Operator Mono Dark",
    window_background_opacity = 0.9,
    initial_rows = 50,
    initial_cols = 200,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    leader = { key = " ", mods = "CTRL" },
    keys = {
        {
            key = 'Enter',
            mods = 'SUPER',
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = 'v',
            mods = 'LEADER',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = 's',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
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
    }
}
