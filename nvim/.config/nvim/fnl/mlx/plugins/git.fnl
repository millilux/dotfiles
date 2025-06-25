(import-macros {: map!} :hibiscus.vim)

(fn next_hunk []
  (if vim.wo.diff
      "]c"
      (do
        (vim.schedule (fn [] (package.loaded.gitsigns.next_hunk)))
        :<Ignore>)))

(fn prev_hunk []
  (if vim.wo.diff
      "[c"
      (do
        (vim.schedule (fn [] (package.loaded.gitsigns.prev_hunk)))
        :<Ignore>)))

(local M [{1 :lewis6991/gitsigns.nvim
           :opts {:current_line_blame_formatter "<abbrev_sha> | <author> | <author_time:%Y-%m-%d> | <summary>"
                  :on_attach (fn []
                               (local gs package.loaded.gitsigns)
                               (map! [n :expr] "]c" next_hunk)
                               (map! [n :expr] "[c" prev_hunk)
                               (map! [nv] :<leader>hs gs.stage_hunk)
                               (map! [nv] :<leader>hr gs.reset_hunk)
                               (map! [:n] :<leader>hu gs.undo_stage_hunk)
                               (map! [:n] :<leader>ga gs.stage_buffer)
                               (map! [:n] :<leader>gr gs.reset_buffer)
                               (map! [:n] :<leader>gb
                                     gs.toggle_current_line_blame)
                               (map! [:n] :<leader>hp gs.preview_hunk)
                               (map! [:n] :<leader>hd gs.diffthis)
                               (map! [:n] :<leader>hD (fn [] (gs.diffthis "~")))
                               (map! [:n] :<leader>td gs.toggle_deleted)
                               ;; Text object
                               ;; (map! [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>")
                               )}}
          {1 :sindrets/diffview.nvim
           :opts {:view {:merge_tool {:layout :diff3_mixed}}}}
          {1 :NeogitOrg/neogit
           :config true
           :dependencies [:nvim-lua/plenary.nvim
                          :sindrets/diffview.nvim
                          :ibhagwan/fzf-lua]}])

M
