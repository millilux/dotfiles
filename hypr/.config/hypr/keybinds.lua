----------------
--- PROGRAMS ---
----------------
local terminal = "wezterm"
local fileManager = "nautilus"
local launcher = "rofi -show drun"
local browser = "firefox"
local imageViewer = "imv"

-------------------
--- KEYBINDINGS ---
-------------------
local mod = "SUPER" -- Sets the "Windows" key as main modifier

hl.bind(mod .. " + Q", hl.dsp.window.close())

-- Window modes
hl.bind(mod .. " + F", hl.dsp.window.float())
hl.bind(mod .. " + SHIFT + M", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo()) -- dwindle
-- hl.bind(mod .. " + S", hl.dsp.layout("togglesplit")) -- dwindle

-- Launch programs
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + I", hl.dsp.exec_cmd(imageViewer .. " ~/Pictures"))   -- quick image viewer (floats, see windowrule)
hl.bind(mod .. " + O", hl.dsp.exec_cmd(terminal .. " start -- fish -lc tmux-sessionizer"))   -- fuzzy jump to a project tmux session

-- Focus windows
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Resize windows
hl.bind(mod .. " + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- hl.bind(mod .. " + R", hl.dsp.submap("resize"))
-- hl.define_submap("resize", function()
--     hl.unbind("down")
--     hl.bind("right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
--     hl.bind("left",  hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
--     hl.bind("down",  hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })
--     hl.bind("up",    hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
--     hl.bind("CTRL + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
--     hl.bind("CTRL + left",  hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
--     hl.bind("CTRL + down",  hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
--     hl.bind("CTRL + up",    hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
--     hl.bind("escape", hl.dsp.submap("reset"))
--     hl.bind("return", hl.dsp.submap("reset"))
-- end)

-- Switch workspace
hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to workspace
hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scroll through existing workspaces with mod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Switch between windows in a floating workspace
-- hl.bind(mod .. " + Tab", hl.dsp.window.cycle_next()) -- change focus to next window
-- hl.bind(mod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true })) -- change focus to previous window
-- hl.bind(mod .. " + Tab", hl.dsp.window.bring_to_top()) -- bring it to the top

hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Switch to last used workspace
-- hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Special workspace (scratchpad)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Lock screen
hl.bind("CTRL + ALT + Q", hl.dsp.exec_cmd("hyprlock"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true, locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Notification Centre
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Color picker
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Voice
-- hl.bind("XF86AudioRecord", hl.dsp.exec_cmd("voxtype record-toggle"))
-- hl.bind(mod .. " + D", hl.dsp.exec_cmd("voxtype record-toggle"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("voxtype record start"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("voxtype record stop"), { release = true })

-------------------
--- SCREENSHOTS ---
-------------------
-- Screenshot monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot window
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot region
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
