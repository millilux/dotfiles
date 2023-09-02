(import-macros {: color! : g! : augroup!} :hibiscus.vim)

(fn findinfiles []
  (vim.fn.inputsave)
  (var search (vim.fn.input "🐕 "))
  (vim.fn.inputrestore)
  (if (= search "")
      (set search (vim.fn.expand :<cword>)))
  (vim.fn.execute (.. "silent! grep! " search :|cwindow|redraw!)))

(fn gitcommit []
  (vim.fn.inputsave)
  (local message (vim.fn.input "🐙 "))
  (vim.fn.inputrestore)
  (let [obj (vim.fn.system [:git :commit :-m message])]
    (print obj)))

(fn livecoding []
  (vim.cmd "highlight Normal ctermbg=None guibg=None")
  (vim.cmd "highlight NormalNC ctermbg=None guibg=None")
  (vim.cmd "highlight SignColumn ctermbg=None guibg=None")
  (vim.cmd "highlight FoldColumn ctermbg=None guibg=None")
  (vim.cmd "highlight LiveCoding ctermbg=black guibg=black")
  (augroup! :live-coding [[WinEnter] * "match LiveCoding /^.\\+$/"]))

{: findinfiles : gitcommit : livecoding}

