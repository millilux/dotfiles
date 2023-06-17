(import-macros {: map!} :hibiscus.vim)

;; Clear search highlights
(map! [:n] "<esc>" ":noh<CR>")

;; Toggle line numbers
(map! [:n] "<leader>n" ":set number! relativenumber!<cr>")

;; Simpler indentation
(map! [:v] :< :<gv)
(map! [:v] :> :>gv)

;; Fuzzy Search
(map! [:n] "<leader>f"  ":FzfLua grep_project<CR>")
(map! [:n] "<c-t>"      ":FzfLua files<CR>")
(map! [:n] "<leader>h"  ":FzfLua oldfiles<CR>")
(map! [:n] "<leader>b"  ":FzfLua buffers<CR>")
(map! [:n] "<leader>cs" ":FzfLua lsp_document_symbols<CR>")
(map! [:n] "<leader>cS" ":FzfLua lsp_workspace_symbols<CR>")


; (map! [:n] "<leader>f"  ":Telescope live_grep<CR>")
; (map! [:n] "<c-t>"      ":Telescope find_files hidden=true<CR>")
; (map! [:n] "<leader>h"  ":Telescope oldfiles<CR>")
; (map! [:n] "<leader>b"  ":Telescope buffers<CR>")
; (map! [:n] "<leader>cs" ":Telescope lsp_document_symbols<CR>")
; (map! [:n] "<leader>cS" ":Telescope lsp_workspace_symbols<CR>")

;; Grep 
(local funcs (require :mlx.functions))
(map! [:n] :\ funcs.findinfiles)
(map! [:n] "<leader>/" ":silent execute 'grep! ' . shellescape(expand('<cword>')) . ' .'<cr>:copen<cr>")

;; Git
(map! [:n] "<leader>gs" ":Git<cr>")
(map! [:n] "<leader>ga" ":Gwrite<cr>")
(map! [:n] "<leader>gc" ":Git commit<cr>")
(map! [:n] "<leader>gd" '(vim.cmd "tabedit %|Gdiffsplit!"))
(map! [:n] "<leader>gb" ":Git blame<cr>")
;; (map! [:n] <leader>gl ":Gclog<cr>") ;; VERY slow
(map! [:n] "<leader>gP" ":Git push<cr>")
(map! [:n] "<leader>gp" ":Git pull<cr>")
(map! [:n] "<leader>gt" ":GitTimeLapse<cr>")

;; File Explorer
;; (map! [:n] "<leader>e" ":NeoTreeFloatToggle<cr>")
;; (map! [:n] "<leader>l" ":NeoTreeRevealToggle<cr>")
(map! [:n] "<leader>e" ":NvimTreeToggle<cr>")
(map! [:n] "<leader>l" ":NvimTreeFindFileToggle!<cr>")

;; Tests
(local neotest (require :neotest))
(map! [:n] "<leader>tn" '(neotest.run.run))
(map! [:n] "<leader>tf" '(neotest.run.run (vim.fn.expand "%")))

;; Code Diagnostics
(map! [:n] "<leader>cd" vim.diagnostic.open_float)
(map! [:n] "[d" vim.diagnostic.goto_prev)
(map! [:n] "]d" vim.diagnostic.goto_next)
(map! [:n] "<leader>q" vim.diagnostic.setloclist)

;; Low tech code formatter for Fennel
(map! [:n] :<F3> ":%!fnlfmt %<cr>")
;; % is the range (all lines). This makes the command act on the current buffer.
;; ! to run an external command
;; % is the current file

;; " Quit Neovim terminal with esc
;; "tnoremap <Esc> <C-\><C-n>

;; Rope
;; let g:ropevim_local_prefix = '<Space>cx'
;; let g:ropevim_global_prefix = '<Space>cr' 
;; nmap <Leader>ai :RopeAutoImport<CR>
