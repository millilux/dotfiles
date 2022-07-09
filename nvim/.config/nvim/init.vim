if has('win32') || has('win64')
    set runtimepath=%HOMEPATH%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

call plug#begin()

" Themes
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/blue-moon'
Plug 'sliminality/wild-cherry-vim'
" Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'drewtempelmeyer/palenight.vim'

" UI
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-peekaboo'  " Preview register contents
Plug 'markonm/traces.vim'     " Highlight patterns & ranges in ex commands in commandline mode
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'nvim-lualine/lualine.nvim'


" File Drawer
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
"
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'nvim-neo-tree/neo-tree.nvim'
" Plug 'MunifTanjim/nui.nvim'

" Text
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'bronson/vim-visual-star-search'
Plug 'wellle/targets.vim'
Plug 'editorconfig/editorconfig-vim'

" Navigation
" Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'

" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junkblocker/git-time-lapse'
Plug 'rbong/vim-flog'
Plug 'lewis6991/gitsigns.nvim'

" Syntax 
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'fatih/vim-nginx'
Plug 'hashivim/vim-terraform'
Plug 'keith/swift.vim'
Plug 'preservim/vim-markdown'
Plug 'dag/vim-fish'

Plug 'nvim-treesitter/nvim-treesitter'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'
" Plug 'ptzz/lf.vim'
" Plug 'voldikss/vim-floaterm'
" Plug 'nvim-lspfuzzy' " alternative to fzf-lsp?

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" IDE
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'liuchengxu/vista.vim'
" Plug 'honza/vim-snippets'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'python-rope/ropevim'
Plug 'jeetsukumaran/vim-pythonsense'

Plug 'janko-m/vim-test'
Plug 'antoinemadec/FixCursorHold.nvim'
" Plug 'nvim-neotest/neotest'
" Plug 'nvim-neotest/neotest-vim-test'
" Plug 'puremourning/vimspector'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" Plug 'onsails/lspkind.nvim'
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" Workflow
Plug 'mbbill/undotree'

call plug#end()

"------------------------------------------------------------------------------
" Basics
"------------------------------------------------------------------------------
filetype plugin on
set nocompatible

set encoding=utf-8
setglobal fileencoding=utf-8

let mapleader = "\<Space>"

set timeoutlen=500
set path=.,**
set hidden " Hide buffers instead of closing them
set ruler
set relativenumber
set autoread
set backspace=indent,eol,start
set clipboard+=unnamedplus
set diffopt+=vertical
set linebreak
set modelines=0
set noshowmode
set shortmess+=c  " No completion messages
set shortmess+=I  " No intro message on open
set signcolumn=yes
set updatetime=300
set wildmenu
set wildignore+=**/node_modules/**
set wildmode=full

set ttyfast
set laststatus=2

set history=1000
set undolevels=1000

set completeopt=menu,menuone,noselect

"------------------------------------------------------------------------------
" Formatting
"------------------------------------------------------------------------------
syntax enable
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set conceallevel=0   " Don't hide JSON quotes

"------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------
set incsearch  " Display matches as you type
set hlsearch
set ignorecase
set smartcase
set gdefault

" Substitution
set inccommand=split

"------------------------------------------------------------------------------
" Windows
"------------------------------------------------------------------------------
set splitbelow
set splitright
set mouse=n

" Automatically remove trailing whitespace when saving
"autocmd FileType python,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

" Fix crontab editing
autocmd filetype crontab setlocal nobackup nowritebackup

"------------------------------------------------------------------------------
" Appearance
"------------------------------------------------------------------------------
set termguicolors
set background=dark
set cursorline

"colorscheme tokyonight
colorscheme palenight
" colorscheme wildcherry
"colorscheme gruvbox
"colorscheme solarized
"colorscheme space_vim_theme
" colorscheme dracula
" colorscheme blue-moon
" colorscheme dracula
" let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
" colorscheme catppuccin

"set gfn=Monaco:h12
let g:airline_theme='palenight'
"let g:solarized_diffmode='high'
"let g:gruvbox_vert_split = 'bg1'
"let g:gruvbox_vert_split = 'bg0'
" let g:palenight_terminal_italics=1
highlight WinSeparator ctermfg=None ctermbg=None guibg=None guifg=None
set fillchars+=vert:\ " Use a whitespace character

" Include any nvim specific lua config from ~/.config/nvim/lua/config.lua
lua require('config')

"------------------------------------------------------------------------------
" Quick Scope
"------------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guibg='#5f55aa' guifg='#afff5f' gui=underline ctermbg=155 cterm=underline
highlight QuickScopeSecondary guibg='#5f55aa' guifg='#5fffff' gui=underline ctermbg=81 cterm=underline

"------------------------------------------------------------------------------
" Sneak
"------------------------------------------------------------------------------
let g:sneak#label = 1
let g:sneak#prompt = '🦄 '
" let g:sneak#prompt = '🦇 '
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermbg=red ctermbg=yellow

"------------------------------------------------------------------------------
" Netrw
"------------------------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_localrmdir = 'rm -r'

"------------------------------------------------------------------------------
" Black
"------------------------------------------------------------------------------
let g:black_skip_string_normalization=1

"------------------------------------------------------------------------------
" Markdown
"------------------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1

"------------------------------------------------------------------------------
" Neosnippet
"------------------------------------------------------------------------------
" let g:neosnippet#snippets_directory = '~/dotfiles/vim/snippets'
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

"------------------------------------------------------------------------------
" Vim-go
"------------------------------------------------------------------------------
"autocmd FileType go nmap <leader>r <Plug>(go-run)
"autocmd FileType go nmap <leader>b <Plug>(go-build)
"autocmd FileType go nmap <leader>t <Plug>(go-test)
"autocmd FileType go nmap <leader>c <Plug>(go-coverage)
"autocmd FileType go nmap <leader>r :GoRename<cr>
"let g:go_auto_type_info = 1

"------------------------------------------------------------------------------
" Vim-test
"------------------------------------------------------------------------------
function! RunTransform(cmd) abort
    " echom a:cmd
    let l:service =  substitute(a:cmd, '\vpython -m pytest services/([a-z-_]+).*', '\1', "")
    let l:cmd = substitute(a:cmd, '\vservices/([a-z-_]+)/', '', '')
    let l:cmd = substitute(l:cmd, 'backend/', '', '')
    let l:cmd = substitute(l:cmd, 'python -m ', '', '')
    return './run ' . l:service . ' ' . l:cmd . ' -vv'
endfunction

let g:test#strategy = 'neovim'
let g:test#custom_transformations = {'run': function('RunTransform')}
let g:test#transformation = 'run'
let test#neovim#term_position = 'vert'

"------------------------------------------------------------------------------
" ALE (Async Lint Engine)
"------------------------------------------------------------------------------
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['black', 'isort'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {'python': ['flake8', 'mypy', 'pylsp']}
let g:ale_python_flake8_change_directory = 'project'
let g:ale_python_pylsp_config = {
\   'pylsp': {
\       'plugins': {
\           'pycodestyle': {
\               'enabled': v:false
\           }
\       }
\   }
\}

let g:ale_completion_enabled = 0
let g:ale_hover_to_floating_preview = 1
let g:ale_hover_cursor = 1

nnoremap gd             :ALEGoToDefinition<cr>
nnoremap <leader>r      :ALERename<cr>
nnoremap <leader>fr     :ALEFindReferences<cr>
nnoremap <leader>ca     :ALECodeAction<cr>
nnoremap <leader>K      :ALEHover<cr>
nnoremap <F3>           :ALEFix<cr>

"------------------------------------------------------------------------------
" Airline
"------------------------------------------------------------------------------
"let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

"------------------------------------------------------------------------------
" Search & Replace
"------------------------------------------------------------------------------
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

function! FindInFiles()
    call inputsave()
    let search = input('🐕 ')
    call inputrestore()
    execute "silent! grep! " . search . "|cwindow|redraw!"
endfunction

function! ReplaceIt()
    call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction

"------------------------------------------------------------------------------
" FZF
"------------------------------------------------------------------------------
 let g:fzf_history_dir = '~/.local/share/fzf-history'
 let g:fzf_tags_command = 'ctags -R --languages=python --exclude=node_modules --exclude=.venv'

 nnoremap <silent> <leader>f     :Rg<CR>
 nnoremap <silent> <leader>b     :Buffers<CR>
 nnoremap <silent> <leader>h     :History:<CR>
 nnoremap <silent> <leader>h/    :History/<CR>
 nnoremap <silent> <leader>m     :Marks<CR>
 nnoremap <silent> <leader>T     :Tags<CR>
 nnoremap <silent> <leader>t     :BTags<CR>

 " Ensure FZF doesn't open in the NERDTree window
 nnoremap <silent> <expr> <c-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

"------------------------------------------------------------------------------
" Telescope
"------------------------------------------------------------------------------
"" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
" Close vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\.git', '\.DS_Store', '\~$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1

"------------------------------------------------------------------------------
" Vista
"------------------------------------------------------------------------------
let g:vista#renderer#enable_icon = 1

"function! NearestMethodOrFunction() abort
  "return get(b:, 'vista_nearest_method_or_function', '')
"endfunction

"set statusline+=%{NearestMethodOrFunction()}

"" Show the nearest function in statusline automatically
"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"------------------------------------------------------------------------------
" Hexokinase (Colours)
"------------------------------------------------------------------------------
let g:Hexokinase_highlighters = ['virtual']

"------------------------------------------------------------------------------
" Vimspector
"------------------------------------------------------------------------------
let g:vimspector_enable_mappings = 'HUMAN'

"------------------------------------------------------------------------------
" Mappings
"------------------------------------------------------------------------------
" Indentation
vnoremap < <gv
vnoremap > >gv

" Simpler Regexes
nnoremap / /\v
vnoremap / /\v

" Clear search highlights
nnoremap <silent> <esc> :noh<cr>

nnoremap <F2> :call ReplaceIt()<cr> <C-o>
nnoremap \ :call FindInFiles()<cr>

" Find in files for current word
nnoremap <leader>/ :silent execute "grep! " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>

nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>l :NERDTreeFind<cr>

" nnoremap <silent> <leader>e :NvimTreeToggle<cr>
" nnoremap <silent> <leader>l :NvimTreeFindFile<cr>

" nnoremap <silent> <leader>e :Neotree<cr>
" nnoremap <silent> <leader>l :Neotree filesystem reveal<cr>

nnoremap <D-/> :NERDComToggleComment<cr>
nnoremap <F8> :Vista!!<cr>
" nnoremap <leader>x Obreakpoint()<ESC>
"nnoremap <leader>t :Vista finder<cr>

" Fugitive
nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :Gdiffsplit!<cr>
nnoremap <leader>gb :Git blame<cr>
" nnoremap <leader>gl :Gclog<cr> " VERY slow
nnoremap <leader>gP :Git push<cr>
nnoremap <leader>gp :Git pull<cr>

" Git Time Lapse
nmap <Leader>gt :GitTimeLapse<cr>

" Vim Test
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tv :TestVisit<CR>

" Undotree
nnoremap <F5> :UndotreeToggle<CR>

" Keep window when deleting a buffer
"nnoremap <leader>bd :bp\|bd#<CR>

nmap <Leader>ai :RopeAutoImport<CR>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Quit Neovim terminal with esc
"tnoremap <Esc> <C-\><C-n>

" Rope
" let g:ropevim_local_prefix = '<Space>cx'
" let g:ropevim_global_prefix = '<Space>cr' 
"
" In time, more refactorings should get added to
" https://github.com/python-rope/pylsp-rope, so will appear under ALECodeAction
