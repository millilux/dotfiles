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

(local filetypes {
              :c " "
              :conf " "
              :cpp " "
              :css " "
              :go " "
              :graphql "󰡷 "
              :haskell " "
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

(fn mode []
  (let [_mode (. (vim.api.nvim_get_mode) :mode)]
    ; (var mode-color "%#StatusLine#")
    (var mode-color "")
    ; (if (= _mode :n) (set mode-color "%#StatusNormal#")
    ;     (or (= _mode :i) (= _mode :ic)) (set mode-color "%#StatusInsert#")
    ;     (or (= _mode :v) (= _mode :V) (= _mode "\022")) (set mode-color "%#StatusVisual#") 
    ;     (= _mode :R) (set mode-color "%#StatusReplace#") 
    ;     (= _mode :c) (set mode-color "%#StatusCommand#") 
    ;     (= _mode :t) (set mode-color "%#StatusTerminal#"))
    (var icon (. modes _mode))
    (.. mode-color (string.format "  %s " icon :upper))))


(fn branch []
  (let [cmd (io.popen "git branch --show-current 2>/dev/null")
        branch (or (cmd:read :*l) (cmd:read :*a))]
    (cmd:close)
    (if (= branch "")
        ""
        (string.format (.. "   " branch)))))

(fn recording []
  (let [recording-reg (vim.fn.reg_recording) 
        playback-reg (vim.fn.reg_executing)]
    (var icon "")
    (if (not= recording-reg "") (set icon (.. " 󰑊 " recording-reg " ")))
    (if (not= playback-reg "") (set icon (.. " 󰐊 " playback-reg " ")))
    icon))

(fn filetype []
  (string.format "%s" (or (. filetypes vim.bo.filetype) "")))

(global Status (fn []
    (table.concat [
        "%#Normal#" ; transparent appearance 
        (mode)
        (branch)
        (recording)
        "%="
        (filetype)
        " %t "     ; file name
        ; " %f "   ; full path
        ; (color)
        " %l:%c  " ; line & column
        ])))

(vim.api.nvim_create_autocmd [:WinEnter :BufEnter]
                             {:command "setlocal statusline=%!v:lua.Status()"
                              :pattern "*"})

