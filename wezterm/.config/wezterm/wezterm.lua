local wezterm = require 'wezterm'
local act = wezterm.action

-- On Mac, command is the super key 

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
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    show_new_tab_button_in_tab_bar = false,
    use_dead_keys = false,
    window_decorations = 'RESIZE', -- Hides the title bar and window controls on macOS
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
    -- font = wezterm.font('JetBrains Mono'),
    -- font = wezterm.font('Cascadia Code NF'),
    -- font = wezterm.font('SpaceMono NF'),
    -- font = wezterm.font('VictorMono NF', { weight = 'Bold'}),
    font_size = 15,
    line_height = 1.4,
    cell_width = 0.85,

    leader = { key = ' ', mods = 'CTRL' },
    keys = {
        {
            key = 'Enter',
            mods = 'LEADER',
            -- action = wezterm.action.ToggleFullScreen,
            action = wezterm.action.EmitEvent 'toggle-opacity'
        },
        { key = 'l', mods = 'SUPER|SHIFT', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' }},
        { key = 'n', mods = 'SUPER|SHIFT', action = act.SwitchWorkspaceRelative(1) },
        { key = 'p', mods = 'SUPER|SHIFT', action = act.SwitchWorkspaceRelative(-1) },
        {
            key = 'x',
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
        -- Fix Arrow Keys within WSL only
        -- { key = 'UpArrow', action = wezterm.action { SendString = '\x1b[A' } },
        -- { key = 'DownArrow', action = wezterm.action { SendString = '\x1b[B' } },
    }
}
