(import-macros {: color! : g! : augroup!} :hibiscus.vim)

(fn findinfiles []
  (vim.fn.inputsave)
  (var search (vim.fn.input "🐕 "))
  (vim.fn.inputrestore)
  (if (= search "")
      (set search (vim.fn.expand :<cword>)))
  (if (not= search "")
      (vim.fn.execute (.. "silent! grep! '" search "'|cwindow|redraw!"))))

(fn gitcommit []
  (vim.fn.inputsave)
  (local message (vim.fn.input "🐙 "))
  (vim.fn.inputrestore)
  (let [obj (vim.fn.system [:git :commit :-m message])]
    (print obj)))

(fn gitcommitamend []
  (local prevmessage (vim.fn.system [:git :log :--pretty=format:%s :-1])) ; https://www.reddit.com/r/neovim/comments/zhweuc/whats_a_fast_way_to_load_the_output_of_a_command/
  (vim.fn.inputsave)
  (local message (vim.fn.input "🔧🐙 " prevmessage))
  (vim.fn.inputrestore)
  (local args [:git :commit :--amend :-m message])
  (let [obj (vim.fn.system args)]
    (print obj)))

(fn foldtext []
  ; (local line (vim.fn.getline vim.v.foldstart))
  ; (local line_count (+ 1 (- vim.v.foldend vim.v.foldstart)))
  (.. "  ..."))

(fn livecoding []
  ; TODO Push current values onto a stack, then pop them off to revert
  (vim.cmd "highlight Normal ctermbg=None guibg=None")
  (vim.cmd "highlight NormalNC ctermbg=None guibg=None")
  (vim.cmd "highlight SignColumn ctermbg=None guibg=None")
  (vim.cmd "highlight FoldColumn ctermbg=None guibg=None")
  ; (vim.cmd "highlight LiveCoding ctermbg=black guibg=black")
  (vim.api.nvim_set_hl 0 :LiveCoding {:bg :black :blend 50})
  (augroup! :live-coding [[WinEnter] * "match LiveCoding /^.\\+$/"]))

(fn fmt []
  (vim.cmd ":w")
  ;; % is the range (all lines)
  ;; ! to run an external command
  ;; % is the current file
  (case vim.bo.filetype
    "fennel" (vim.cmd "%!fnlfmt %")
    "sh" (vim.cmd "%!shfmt %")
    "json" (vim.cmd "%!jq")
    ))

;; (let [obj (vim.fn.system [:fnlfmt (vim.api.nvim_buf_get_name 0)])] 
;;   (print obj) 
;;   (vim.api.nvim_buf_set_lines 0 0 0 false [ obj ]))

{: findinfiles : gitcommit : gitcommitamend : fmt : livecoding : foldtext}
