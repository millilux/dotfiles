if has('win32') || has('win64')
    set runtimepath=%HOMEPATH%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvie/vim-flake8'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mfukar/robotframework-vim'
Plug 'fatih/vim-nginx'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
Plug 'mbbill/undotree'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'vim-syntastic/syntastic'
"Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'Chiel92/vim-autoformat'
Plug 'joonty/vdebug'
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
set background=dark
colorscheme solarized
set gfn=Monaco:h12
let g:airline_theme='solarized'
let g:solarized_diffmode='high'

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
set smartindent
set autoindent
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
autocmd FileType javascript,python autocmd BufWritePre <buffer> :%s/\s\+$//e

"------------------------------------------------------------------------------
" Flake8
"------------------------------------------------------------------------------
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=1


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
" FZF
"------------------------------------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Use RipGrep with FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Mapping to ensure FZF doesn't open in the NERDTree window
nnoremap <silent> <expr> <c-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
" Open if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1

"------------------------------------------------------------------------------
" Mappings
"------------------------------------------------------------------------------
" Indent shortcuts
vnoremap < <gv
vnoremap > >gv

nnoremap <F2> :call ReplaceIt()<cr> <C-o>
"nnoremap <c-t> :FZF<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>e :NERDTreeToggle<cr>
"nnoremap <leader>d :YcmCompleter GoTo<cr>
nnoremap <D-/> :NERDComToggleComment<cr>

nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

nnoremap <F3> :Autoformat<cr>

" Quickfix
nnoremap <silent> <F8> :cnext<cr>
nnoremap <silent> <S-F8> :cprev<cr>

function! ReplaceIt()
call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction
