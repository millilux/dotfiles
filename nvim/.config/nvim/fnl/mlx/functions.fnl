(fn findinfiles []
    (vim.fn.inputsave)
    (local search (vim.fn.input "🐕 "))
    ; TODO: if search term is empty, use currentword
    (vim.fn.inputrestore)
    (vim.fn.execute (.. "silent! grep! " search "|cwindow|redraw!"))
)

{:findinfiles findinfiles}
