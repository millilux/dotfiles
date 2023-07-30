(import-macros {: map!} :hibiscus.vim)

(fn next_hunk []
  (if vim.wo.diff "]c" (do
                         (vim.schedule (fn []
                                         (package.loaded.gitsigns.next_hunk)))
                         :<Ignore>)))

(fn prev_hunk []
  (if vim.wo.diff "[c" (do
                         (vim.schedule (fn []
                                         (package.loaded.gitsigns.prev_hunk)))
                         :<Ignore>)))

(local M [{1 :tpope/vim-fugitive}
          {1 :lewis6991/gitsigns.nvim
           :opts {:on_attach (fn []
                               (local gs package.loaded.gitsigns)
                               (map! [n :expr] "]c" next_hunk)
                               (map! [n :expr] "[c" prev_hunk)
                               (map! [nv] :<leader>hs ":Gitsigns stage_hunk<CR>")
                               (map! [nv] :<leader>hr ":Gitsigns reset_hunk<CR>")
                               (map! [:n] :<leader>hS gs.stage_buffer)
                               (map! [:n] :<leader>hu gs.undo_stage_hunk)
                               (map! [:n] :<leader>hR gs.reset_buffer)
                               (map! [:n] :<leader>hp gs.preview_hunk)
                               ;; (map! [:n] "<leader>hb" function() gs.blame_line { full = true } end)
                               (map! [:n] :<leader>tb gs.toggle_current_line_blame)
                               (map! [:n] :<leader>hd gs.diffthis)
                               ;; (map! [:n] "<leader>hD" function() gs.diffthis("~") end)
                               (map! [:n] :<leader>td gs.toggle_deleted)

                                ;; Text object
                               ;; (map! [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>")

                               )
                }}
          {1 :sindrets/diffview.nvim}
          {1 :junkblocker/git-time-lapse}])

M

