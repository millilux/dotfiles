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
  ; (let [obj (vim.fn.system [:ls :-l])]
  (let [obj (vim.fn.system [:git :commit :-m message])]
    (print obj)))

{: findinfiles : gitcommit}

