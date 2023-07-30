(import-macros {: map!} :hibiscus.vim)
(local mlx (require :mlx.functions))

;; Clear search highlights
(map! [:n] "<esc>" ":noh<CR>")

;; Toggle line numbers
(map! [:n] "<leader>n" ":set number! relativenumber!<cr>")

;; Simpler indentation
(map! [:v] :< :<gv)
(map! [:v] :> :>gv)

;; Run macros over visual range
(map! [:x :expr] "@" "':norm @' . getcharstr() . '<cr>'")

;; Buffers
(map! [:n] "<leader>b" ":FzfLua buffers<CR>")
(map! [:n] "[b" ":bprev<CR>")
(map! [:n] "]b" ":bnext<CR>")

;; Windows
(map! [:n] "<c-h>" "<c-w>h<CR>")
(map! [:n] "<c-j>" "<c-w>j<CR>")
(map! [:n] "<c-k>" "<c-w>k<CR>")
(map! [:n] "<c-l>" "<c-w>l<CR>")

;; Tabs
(map! [:n] "<leader><tab>"  ":FzfLua tabs<CR>")
(map! [:n] "<leader><tab>c" ":tabclose<CR>")
(map! [:n] "[<tab>"         ":tprev<CR>")
(map! [:n] "]<tab>"         ":next<CR>")

;; Quickfix
(map! [:n] "[q" ":cprev<CR>")
(map! [:n] "]q" ":cnext<CR>")

;; Location List
(map! [:n] "[l" ":lprev<CR>")
(map! [:n] "]l" ":lnext<CR>")

;; Files
(map! [:n] "<c-t>"     ":FzfLua files<CR>")
(map! [:n] "<leader>h" ":FzfLua oldfiles<CR>")
(map! [:n] "<leader>e" ":NvimTreeToggle<cr>")
(map! [:n] "<leader>l" ":NvimTreeFindFileToggle!<cr>")
;; (map! [:n] "<leader>e" ":neotreefloattoggle<cr>")
;; (map! [:n] "<leader>l" ":neotreerevealtoggle<cr>")

;; Grep
(map! [:n] "<leader>f" ":FzfLua grep_project<CR>")
(map! [:n] "<leader>/" mlx.findinfiles)

;; Code
(map! [:n] "<leader>cs" ":FzfLua lsp_document_symbols<CR>")
(map! [:n] "<leader>cS" ":FzfLua lsp_workspace_symbols<CR>")
(map! [:n] "<leader>co" ":AerialToggle!<cr>")

;; Diagnostics
(map! [:n] "<leader>cd" vim.diagnostic.open_float)
(map! [:n] "[d" vim.diagnostic.goto_prev)
(map! [:n] "]d" vim.diagnostic.goto_next)
(map! [:n] "<leader>q" vim.diagnostic.setloclist)

;; Tests
(local neotest (require :neotest))
(map! [:n] "<leader>tn" '(neotest.run.run))
(map! [:n] "<leader>tf" '(neotest.run.run (vim.fn.expand "%")))

;; Git
(map! [:n] "<leader>bc" ":DiffviewFileHistory %<CR>")
; (map! [:n] "<leader>bc" ":FzfLua git_bcommits<CR>")
(map! [:n] "<leader>gs" ":vertical Git<cr>")
(map! [:n] "<leader>ga" ":Gwrite<cr>")
; (map! [:n] "<leader>gc" ":Git commit -m<cr>")
(map! [:n] "<leader>gc" mlx.gitcommit)
; (map! [:n] "<leader>gd" '(vim.cmd "tabnew %|Gdiffsplit!"))
(map! [:n] "<leader>gd" ":DiffviewOpen<cr>")
(map! [:n] "<leader>gb" ":Git blame<cr>")
; (map! [:n] "<leader>gl" ":FzfLua git_commits<cr>")
(map! [:n] "<leader>gl" ":DiffviewFileHistory<cr>")
(map! [:n] "<leader>gP" ":Git push<cr>")
(map! [:n] "<leader>gp" ":Git pull<cr>")

;; Undo
(map! [:n] "<leader>u" ":UndotreeToggle<cr>")

;; Fuzzy Search
(map! [:n] "<leader>z" ":FzfLua<cr>")

;; Low tech code formatter for Fennel
(map! [:n] :<F3> ":%!fnlfmt %<cr>")
;; % is the range (all lines)
;; ! to run an external command
;; % is the current file

;; " Quit Neovim terminal with esc
;; "tnoremap <Esc> <C-\><C-n>
;; https://github.com/neovim/neovim/issues/7648

;; Rope
;; let g:ropevim_local_prefix = '<Space>cx'
;; let g:ropevim_global_prefix = '<Space>cr' 
;; nmap <Leader>ai :RopeAutoImport<CR>

;; Telescope
; (map! [:n] "<leader>f"  ":Telescope live_grep<CR>")
; (map! [:n] "<c-t>"      ":Telescope find_files hidden=true<CR>")
; (map! [:n] "<leader>h"  ":Telescope oldfiles<CR>")
; (map! [:n] "<leader>b"  ":Telescope buffers<CR>")
; (map! [:n] "<leader>cs" ":Telescope lsp_document_symbols<CR>")
; (map! [:n] "<leader>cS" ":Telescope lsp_workspace_symbols<CR>")
