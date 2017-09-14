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
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'mbbill/undotree'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'vim-syntastic/syntastic'
call plug#end()

filetype plugin on
set nocompatible

let mapleader = "\<Space>"

set ruler
set relativenumber
set ignorecase
set smartcase
syntax enable

set background=dark
colorscheme solarized
set gfn=Monaco:h12
let g:airline_theme='solarized'
let g:solarized_diffmode='high'

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set inccommand=split
set incsearch
set hlsearch
set gdefault
set cursorline
set wildmenu
set wildmode=list:longest
set smartindent
set autoindent
set clipboard=unnamed
set backspace=indent,eol,start

" autocomplete
set infercase
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set complete-=i

" New window opening
set splitbelow
set splitright

" Automatically remove trailing whitespace when saving
autocmd FileType javascript,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Flake8 config
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=1

" Syntastic config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']

" Deocomplete
let g:deoplete#enable_at_startup=1

" Handle completions with deocomplete instead of jedi-vim
let g:jedi#completions_enabled = 0

set ttyfast
set laststatus=2

set history=1000
set undolevels=1000

set encoding=utf-8
setglobal fileencoding=utf-8

function! ReplaceIt()
call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction

" Speed up esc for vim-airline
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif


" FZF config
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


" Ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Indent shortcuts
vnoremap < <gv
vnoremap > >gv

nnoremap <F2> :call ReplaceIt()<cr> <C-o>
nnoremap <c-t> :FZF<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>e :NERDTreeToggle<cr>
"nnoremap <leader>d :YcmCompleter GoTo<cr>
nnoremap <D-/> :NERDComToggleComment<cr>

nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
