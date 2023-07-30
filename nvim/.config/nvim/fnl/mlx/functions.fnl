(fn findinfiles []
    (vim.fn.inputsave)
    (var search (vim.fn.input "🐕 "))
    (vim.fn.inputrestore)
    (if (= search "")
        (set search (vim.fn.expand "<cword>")))
    (vim.fn.execute (.. "silent! grep! " search "|cwindow|redraw!"))
)

{:findinfiles findinfiles}
