(import-macros {: map!} :hibiscus.vim)
(local mlx (require :mlx.functions))

;; Clear search highlights
(map! [:n] "<esc>" ":noh<CR>")

;; Toggle line numbers
(map! [:n] "<leader>n" ":set number! relativenumber!<CR>")

;; Simpler indentation
(map! [:v] :< :<gv)
(map! [:v] :> :>gv)

;; Run macros over visual range
(map! [:x :expr] "@" "':norm @' . getcharstr() . '<CR>'")

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
(map! [:n] "<leader><tab>n" ":tabnew<CR>")
(map! [:n] "[<tab>"         ":tabprevious<CR>")
(map! [:n] "]<tab>"         ":tabnext<CR>")

;; Quickfix
(map! [:n] "[q" ":cprev<CR>")
(map! [:n] "]q" ":cnext<CR>")

;; Location List
(map! [:n] "[l" ":lprev<CR>")
(map! [:n] "]l" ":lnext<CR>")

;; Files
(map! [:n] "<c-t>"     ":FzfLua files<CR>")
(map! [:n] "<leader>h" ":FzfLua oldfiles<CR>")
; Moved to lazyvim config
; (map! [:n] "<leader>e" ":NvimTreeToggle<CR>")
; (map! [:n] "<leader>l" ":NvimTreeFindFileToggle!<CR>")
;; (map! [:n] "<leader>e" ":neotreefloattoggle<CR>")
;; (map! [:n] "<leader>l" ":neotreerevealtoggle<CR>")

;; Grep
(map! [:n] "<leader>f" ":FzfLua grep_project<CR>")
(map! [:n] "<leader>/" mlx.findinfiles)

;; Code
(map! [:n] "<leader>cs" ":FzfLua lsp_document_symbols<CR>")
(map! [:n] "<leader>cS" ":FzfLua lsp_workspace_symbols<CR>")
; Moved to lazyvim config
; (map! [:n] "<leader>o" ":AerialToggle!<CR>")

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
(map! [:n] "<leader>bc" ":DiffviewFileHistory % --no-merges<CR>")
; (map! [:n] "<leader>bc" ":FzfLua git_bcommits<CR>")
; (map! [:n] "<leader>gs" ":vertical Git<CR>")
; (map! [:n] "<leader>ga" ":Gwrite<CR>")
; (map! [:n] "<leader>gc" ":Git commit -m<CR>")
(map! [:n] "<leader>gc" mlx.gitcommit)
(map! [:n] "<leader>gA" mlx.gitcommitamend)
; (map! [:n] "<leader>gd" '(vim.cmd "tabnew %|Gdiffsplit!"))
(map! [:n] "<leader>gd" ":DiffviewOpen<CR>")
; (map! [:n] "<leader>gb" ":Git blame<CR>")
; (map! [:n] "<leader>gl" ":FzfLua git_commits<CR>")
(map! [:n] "<leader>gl" ":DiffviewFileHistory<CR>")
; (map! [:n] "<leader>gP" ":Git push<CR>")
; (map! [:n] "<leader>gp" ":Git pull<CR>")

;; Undo
;; Moved to lazyvim config
; (map! [:n] "<leader>u" ":UndotreeToggle<CR>")

;; Fuzzy Search
(map! [:n] "<leader>z" ":FzfLua<CR>")

;; Low tech code formatter for languages without LSP formatters
(map! [:n] :<F3> mlx.fmt)

(local flash (require :flash))
(map! [:no] :s flash.jump)
; (map! [:n] :S '(flash.jump {:continue true}))
; (map! [:no] :S flash.treesitter)
(map! [:o] :r flash.remote)
; (map! [:ox] :R flash.treesitter_search)
; (map! [:c] :<c-s> flash.toggle)

;; Live Coding 
(map! [:n] "<leader>v" mlx.livecoding)

; WIP Git commit message pop up
; (local bufnr (vim.api.nvim_create_buf false true))
; (vim.api.nvim_buf_set_option bufnr :bufhidden :wipe)
; (vim.api.nvim_buf_set_lines bufnr 0 -1 true ["Hello"])
; (local opts {
;     :style "minimal"
;     :relative "editor"
;     :width 40
;     :height 10
;     :row 10
;     :col 10
;     :focusable true
;     :border "rounded"
; })
; (local win_id (vim.api.nvim_open_win bufnr true opts))

;; " Quit Neovim terminal with esc
;; "tnoremap <Esc> <C-\><C-n>
;; https://github.com/neovim/neovim/issues/7648

;; Rope
;; let g:ropevim_local_prefix = '<Space>cx'
;; let g:ropevim_global_prefix = '<Space>CR' 
;; nmap <Leader>ai :RopeAutoImport<CR>

;; Telescope
; (map! [:n] "<leader>f"  ":Telescope live_grep<CR>")
; (map! [:n] "<c-t>"      ":Telescope find_files hidden=true<CR>")
; (map! [:n] "<leader>h"  ":Telescope oldfiles<CR>")
; (map! [:n] "<leader>b"  ":Telescope buffers<CR>")
; (map! [:n] "<leader>cs" ":Telescope lsp_document_symbols<CR>")
; (map! [:n] "<leader>cS" ":Telescope lsp_workspace_symbols<CR>")
