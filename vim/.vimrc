if has('win32') || has('win64')
    set runtimepath=%HOMEPATH%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

let g:python3_host_prog = '/usr/local/bin/python3'

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
"Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'nvie/vim-flake8'
"Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mfukar/robotframework-vim'
Plug 'fatih/vim-nginx'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
"Plug 'SkyLeach/pudb.vim'
Plug 'mbbill/undotree'
Plug 'bronson/vim-visual-star-search'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'vim-syntastic/syntastic'
"Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
"Plug 'Chiel92/vim-autoformat'
Plug 'joonty/vdebug'
Plug 'janko-m/vim-test'
Plug 'wellle/targets.vim'
call plug#end()

filetype plugin on
set nocompatible

let mapleader = "\<Space>"

set ruler
set relativenumber
set ignorecase
set smartcase
syntax enable

"------------------------------------------------------------------------------
" Appearance
"------------------------------------------------------------------------------
set termguicolors
set background=dark
colorscheme gruvbox
"colorscheme solarized
"set gfn=Monaco:h12
"let g:airline_theme='solarized'
"let g:solarized_diffmode='high'
let g:airline_theme='gruvbox'
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_vert_split = 'bg0'

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

set inccommand=split
set incsearch
set hlsearch
set gdefault
set cursorline
set wildmenu
set wildmode=list:longest,full
set clipboard=unnamed
set backspace=indent,eol,start

set ttyfast
set laststatus=2

set history=1000
set undolevels=1000

set encoding=utf-8
setglobal fileencoding=utf-8

" Autocomplete
"set infercase
"set omnifunc=syntaxcomplete#Complete
"set completefunc=syntaxcomplete#Complete
"set complete-=i

" New windows
set splitbelow
set splitright

" Automatically remove trailing whitespace when saving
autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Fix crontab editing
autocmd filetype crontab setlocal nobackup nowritebackup


"------------------------------------------------------------------------------
" Flake8
"------------------------------------------------------------------------------
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_show_in_file=1
"let g:flake8_show_in_gutter=1



"------------------------------------------------------------------------------
" Black
"------------------------------------------------------------------------------
let g:black_skip_string_normalization=1

"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']


"------------------------------------------------------------------------------
" Deocomplete
"------------------------------------------------------------------------------
let g:deoplete#enable_at_startup=1


"------------------------------------------------------------------------------
" Neosnippet
"------------------------------------------------------------------------------
let g:neosnippet#snippets_directory = '~/dotfiles/vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"------------------------------------------------------------------------------
" Vim-go
"------------------------------------------------------------------------------
"autocmd FileType go nmap <leader>r <Plug>(go-run)
"autocmd FileType go nmap <leader>b <Plug>(go-build)
"autocmd FileType go nmap <leader>t <Plug>(go-test)
"autocmd FileType go nmap <leader>c <Plug>(go-coverage)
autocmd FileType go nmap <leader>r :GoRename<cr>
let g:go_auto_type_info = 1

"------------------------------------------------------------------------------
" Jedi
"------------------------------------------------------------------------------
" Handle completions with deocomplete instead of jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#force_py_version = 3

"------------------------------------------------------------------------------
" Tern
"------------------------------------------------------------------------------
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx']


"------------------------------------------------------------------------------
" Ale
"------------------------------------------------------------------------------
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['black'],
\}

let g:ale_python_black_options = '--skip-string-normalization'

"------------------------------------------------------------------------------
" Vim Airline
"------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
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
" RipGrep
"------------------------------------------------------------------------------
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"------------------------------------------------------------------------------
" FZF
"------------------------------------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Setup ripgrep search with FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping to ensure FZF doesn't open in the NERDTree window
nnoremap <silent> <expr> <c-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"


" Grep things
command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen 12 
nnoremap <leader>/ :silent execute "grep! " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>
"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
" Open if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\.git', '\.DS_Store', '\~$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1

"------------------------------------------------------------------------------
" Mappings
"------------------------------------------------------------------------------
" Indentation
vnoremap < <gv
vnoremap > >gv

nnoremap <F2> :call ReplaceIt()<cr> <C-o>
nnoremap <silent> <expr> <leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg \<cr>"
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>l :NERDTreeFind<cr>
nnoremap <D-/> :NERDComToggleComment<cr>
nmap <leader>t :TagbarToggle<cr>

nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gs :Gstatus<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

nnoremap <F3> :ALEFix<cr>

" Pudb
"nnoremap <F8> :TogglePudbBreakPoint<CR>
"inoremap <F8> <ESC>:TogglePudbBreakPoint<CR>a

function! ReplaceIt()
call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction
