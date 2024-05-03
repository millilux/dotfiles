(import-macros {: g! : set! : rem! : set+ : augroup!} :hibiscus.vim)
(local mlx (require :mlx.functions))

(g! mapleader " ")
(g! mapleaderlocal " m")
; (g! conjure#filetype#fennel :conjure.client.fennel.stdio)
(g! undotree_WindowLayout 3)
(g! undotree_HelpLine 0)
(g! fzf_tags_command "ctags -R --languages=python --exclude=node_modules --exclude=.venv")
(g! sexp_enable_insert_mode_mappings 0)
(g! db_ui_use_nerd_fonts 1)

;; Basics
(set! timeoutlen 300)
(set! path ".,**")
(set! hidden) ;; Hide buffers instead of closing them
(set! ruler)
(set! foldenable true)
(set! foldcolumn "1")
(set! foldlevel 99)
(set! foldlevelstart 99)
(set! foldnestmax 1)
(set! foldmethod "indent")
; (set! foldmethod "expr")
; (set! foldexpr "nvim_treesitter#foldexpr()")
(set! foldclose "all")
(set! foldopen "all")
(set! foldtext  "v:lua.require('mlx.functions').foldtext()")
(set! signcolumn "yes:1")
(set! autoread)
(set! backspace "indent,eol,start")
(set+ clipboard "unnamedplus") ; Very slow under WSL
(set+ diffopt "vertical")
(set! linebreak)
(set! modelines 0)
(set! noshowmode)
(set+ shortmess :c) ;; No completion messages
(set+ shortmess :I) ;; No intro message on open
(set! updatetime 300)
(set! wildmenu)
(set+ wildignore :**/node_modules/**)
(set! wildmode :full)
(set! ttyfast)
(set! history 1000)
(set! undolevels 1000)
(set! swapfile false)
(set! undofile true)
(set! completeopt "menu,menuone,preview,longest,noselect")
(set! spell true)
(set! spelllang :en_gb)

;; Formatting
(set! autoindent)
(set! smarttab)
(set! expandtab)
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)
(set! shiftround)
(set! conceallevel 1)

;; Search
(set! incsearch)  ;; Display matches as you type
(set! hlsearch)
(set! ignorecase)
(set! smartcase)
(set! gdefault)
(set! inccommand "split") ;; Show substitutions as you type

;; Grep
(set! grepprg "rg --vimgrep --no-heading")
(set! grepformat "%f:%l:%c:%m,%f:%l:%m")

;; Windows
(set! splitbelow)
(set! splitright)
(set! mouse :n)

;; Appearance
(set! termguicolors)
(set! background :dark)
; (set! cursorline)
(set+ fillchars {:vert " "
                 :horiz " "
                 :eob " "
                 :fold " "
                 :foldopen ""
                 :foldsep " "
                 :foldclose ""})
(set! cmdheight 0)
(set! laststatus 3) ;; Set to 3 for neovim's global statusline, 0 to turn it off completely
(set! scrolloff 12)

(augroup! :auto-save [[BufLeave FocusLost] "*" (fn [] 
            (local b (vim.api.nvim_get_current_buf))
            (when (and (vim.api.nvim_buf_get_option b "modified") 
                       (= (vim.fn.getbufvar b "&modifiable") 1))
                (when (= (vim.fn.getbufvar b "&buftype") "")
                    (when (not= (vim.fn.bufname) "")
                        (vim.cmd "silent update")
                        (print (string.format "Saved: %s %s" (vim.fn.expand "%:t") (os.date "%X")))))
            ))])

; Fix crontab editing
; autocmd filetype crontab setlocal nobackup nowritebackup

; Keep window when deleting a buffer
; nnoremap <leader>bd :bp\|bd#<CR>

; (augroup! :clipboard [
;     [BufReadPost BufNewFile] * "set clipboard=unnamedplus"
; ])
