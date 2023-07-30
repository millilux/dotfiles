(local modes {:n " "
              :no " "
              :nov " "
              :noV " "
              "no\022" " "
              :niI " "
              :niR " "
              :niV " "
              :i " "
              :ic " "
              :ix " "
              :s " "
              :S " "
              :r "﯒ "
              :r? " "
              :c " "
              :t " "
              :! " "
              :R " "
              "\022" " "
              :v " "
              :V " "})

(local icons {:c " "
              :conf " "
              :cpp " "
              :css " "
              :go " "
              :haskel " "
              :html " "
              :java " "
              :javascript " "
              :javascriptreact " "
              :lua " "
              :markdown " "
              :python " "
              :ruby " "
              :rust " "
              :scss " "
              :sh " "
              :term " "
              :txt " "
              :typescript " "
              :vim " "
              :zsh " "})

(fn color []
  (let [mode (. (vim.api.nvim_get_mode) :mode)]
    (var mode-color "%#StatusLine#")
    (if (= mode :n) (set mode-color "%#StatusNormal#")
        (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
        (or (= mode :v) (= mode :V) (= mode "\022")) (set mode-color "%#StatusVisual#") 
        (= mode :R) (set mode-color "%#StatusReplace#") 
        (= mode :c) (set mode-color "%#StatusCommand#") 
        (= mode :t) (set mode-color "%#StatusTerminal#"))
    mode-color))

(fn branch []
  (let [cmd (io.popen "git branch --show-current 2>/dev/null")
        branch (or (cmd:read :*l) (cmd:read :*a))]
    (cmd:close)
    (if (= branch "")
        ""
        (string.format (.. "   " branch))
        )))

(fn recording []
  (let [recording_reg (vim.fn.reg_recording) playback_reg (vim.fn.reg_executing)]
    (var icon "")
    (if (not= recording_reg "") (set icon (.. " 󰑊 " recording_reg " ")))
    (if (not= playback_reg "") (set icon (.. " 󰐊 " playback_reg " ")))
    icon))

(global Status (fn []
    (table.concat [
        ; (color)
        (string.format "  %s " (. modes (. (vim.api.nvim_get_mode) :mode)) :upper)
        "%#StatusActive#"
        (branch)
        (recording)
        "%="
        (string.format "%s" (or (. icons vim.bo.filetype) ""))
        " %t "     ; file name
        ; " %f "   ; full path
        ; (color)
        " %l:%c  " ; line & column
        ])))

(vim.api.nvim_create_autocmd [:WinEnter :BufEnter]
                             {:command "setlocal statusline=%!v:lua.Status()"
                              :pattern "*"})

