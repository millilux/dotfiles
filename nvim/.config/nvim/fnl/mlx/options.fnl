(import-macros {: g! : set! : rem! : set+} :hibiscus.vim)

(g! mapleader " ")
(g! mapleaderlocal " m")
;; (g! conjure#filetype#fennel "conjure.client.fennel.stdio")
(g! sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")

(g! fzf_tags_command "ctags -R --languages=python --exclude=node_modules --exclude=.venv")

;; Basics
(set! timeoutlen 300)
(set! path ".,**")
(set! hidden) ;; Hide buffers instead of closing them
(set! ruler)
(set! foldcolumn "1")
(set! signcolumn "yes:1")
(set! autoread)
(set! backspace "indent,eol,start")
(set+ clipboard "unnamedplus")
(set+ diffopt "vertical")
(set! linebreak)
(set! modelines 0)
(set! noshowmode)
(set+ shortmess "c")  ;; No completion messages
(set+ shortmess "I")  ;; No intro message on open
(set! updatetime 300)
(set! wildmenu)
(set+ wildignore "**/node_modules/**")
(set! wildmode "full")
(set! ttyfast)
(set! laststatus 0)
(set! history 1000)
(set! undolevels 1000)
(set! completeopt "menu,menuone,preview,longest,noselect")

;; Formatting
(set! autoindent)
(set! smarttab)
(set! expandtab)
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)
(set! shiftround)
(set! conceallevel 0)  ;; Don"t hide JSON quotes

;; Search
(set! incsearch)  ;; Display matches as you type
(set! hlsearch)
(set! ignorecase)
(set! smartcase)
(set! gdefault)
(set! inccommand "split") ;; Show substitutions as you type

(set! grepprg "rg --vimgrep --no-heading")
(set! grepformat "%f:%l:%c:%m,%f:%l:%m")

;; Windows
(set! splitbelow)
(set! splitright)
(set! mouse :n)

;; Appearance
(set! termguicolors)
(set! background "dark")
(set! cursorline)
(set+ fillchars {:vert " " :horiz " " :eob " " })
(set! cmdheight 0)
(set! scrolloff 4)

;; Fix crontab editing
;; autocmd filetype crontab setlocal nobackup nowritebackup

;; Automatically remove trailing whitespace when saving
;; autocmd FileType python,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

;; Grep for current word
;; nnoremap <leader>/ :silent execute "grep! " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>

;; Keep window when deleting a buffer
;; nnoremap <leader>bd :bp\|bd#<CR>
