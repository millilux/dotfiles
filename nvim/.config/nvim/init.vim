if has('win32') || has('win64')
    set runtimepath=%HOMEPATH%/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

let g:python3_host_prog = '/opt/homebrew/bin/python3'

" Automatically install vim-plug

" if has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall | source $MYVIMRC
"endif

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

" Themes
"Plug 'altercation/vim-colors-solarized'
"Plug 'connorholyday/vim-snazzy'
"Plug 'morhetz/gruvbox'
"Plug 'liuchengxu/space-vim-theme'
Plug 'drewtempelmeyer/palenight.vim'
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Plug 'dracula/vim'


Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'mfukar/robotframework-vim'
Plug 'fatih/vim-nginx'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junegunn/goyo.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'honza/vim-snippets'
Plug 'liuchengxu/vista.vim'
Plug 'junkblocker/git-time-lapse'
"Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'dense-analysis/ale'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'davidhalter/jedi'
" Plug 'davidhalter/jedi-vim'
" Plug 'python-rope/ropevim'
Plug 'jeetsukumaran/vim-pythonsense'
" Plug 'zchee/deoplete-jedi'
"Plug 'zchee/deoplete-go'
Plug 'mbbill/undotree'
Plug 'bronson/vim-visual-star-search'
Plug 'rbong/vim-flog'
Plug 'janko-m/vim-test'
Plug 'wellle/targets.vim'
"Plug 'preservim/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'markonm/traces.vim'
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
Plug 'dag/vim-fish'
Plug 'keith/swift.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'SkyLeach/pudb.vim'  " No way to Docker?
call plug#end()

filetype plugin on
set nocompatible

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

set encoding=utf-8
setglobal fileencoding=utf-8

"------------------------------------------------------------------------------
" Appearance
"------------------------------------------------------------------------------
set termguicolors
set background=dark
set cursorline
" colorscheme tokyonight
colorscheme palenight
"colorscheme gruvbox
"colorscheme solarized
"colorscheme space_vim_theme
"colorscheme dracula
"set gfn=Monaco:h12
"let g:airline_theme='solarized'
"let g:solarized_diffmode='high'
"let g:airline_theme='gruvbox'
"let g:airline_theme='base16_spacemacs'
"let g:gruvbox_vert_split = 'bg1'
"let g:gruvbox_vert_split = 'bg0'
let g:palenight_terminal_italics=1
highlight VertSplit guibg=None guifg=Gray ctermbg=0 ctermfg=0


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
set inccommand=split
set conceallevel=0   " Don't hide JSON quotes

"------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------
set incsearch  " Display matches as you type
set hlsearch
set ignorecase
set smartcase
set gdefault

" Autocomplete
"set infercase
"set omnifunc=syntaxcomplete#Complete
"set completefunc=syntaxcomplete#Complete
"set complete-=i

" Windows
set splitbelow
set splitright
set mouse=n

" Automatically remove trailing whitespace when saving
"autocmd FileType python,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

" Fix crontab editing
autocmd filetype crontab setlocal nobackup nowritebackup

"------------------------------------------------------------------------------
" Sneak
"-----------------------------------------------------------------------------
let g:sneak#label = 1

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
" Quickscope
"------------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

"------------------------------------------------------------------------------
" CoC
"------------------------------------------------------------------------------
"let g:coc_global_extensions = ['coc-python', 'coc-json']

"" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

"" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

"" Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-j>'

"" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'

"" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)


"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction

"" Remap for rename current word
"nmap <leader>r <Plug>(coc-rename)

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Create mappings for function text object, requires document symbols feature of
"" languageserver.

"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

"" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"function! StatusDiagnostic() abort
    "let info = get(b:, 'coc_diagnostic_info', {})
    "if empty(info) | return '' | endif
    "let msgs = []
    "if get(info, 'error', 0)
    "call add(msgs, 'E' . info['error'])
    "endif
    "if get(info, 'warning', 0)
    "call add(msgs, 'W' . info['warning'])
    "endif
    "return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
"endfunction

"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
""set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"autocmd FileType python let b:coc_root_patterns = ["backend/", "pytest.ini", "manage.py", "build.sh"]
"------------------------------------------------------------------------------
" Deoplete
"------------------------------------------------------------------------------
" let g:deoplete#enable_at_startup=1

"------------------------------------------------------------------------------
" Neosnippet
"------------------------------------------------------------------------------
let g:neosnippet#snippets_directory = '~/dotfiles/vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"if has('conceal')
  "set conceallevel=2 concealcursor=niv
"endif

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
" Jedi
"------------------------------------------------------------------------------
" Handle completions with deocomplete instead of jedi-vim
" let g:jedi#completions_enabled = 0
"let g:jedi#force_py_version = 3

"------------------------------------------------------------------------------
" Tern
"------------------------------------------------------------------------------
"let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx']

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

" let g:test#strategy = 'iterm'
let g:test#strategy = 'neovim'
let g:test#custom_transformations = {'run': function('RunTransform')}
let g:test#transformation = 'run'
let test#neovim#term_position = 'vert'

"------------------------------------------------------------------------------
" Ale
"------------------------------------------------------------------------------
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['black', 'isort'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {'python': ['flake8', 'mypy', 'pylsp']}
let g:ale_python_flake8_change_directory = 0
let g:ale_completion_enabled = 1

nnoremap gd             :ALEGoToDefinition<cr>
nnoremap <leader>r      :ALERename<cr>
nnoremap <leader>fr     :ALEFindReferences<cr>
nnoremap <leader>s      :ALESymbolSearch<cr>
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
" RipGrep
"------------------------------------------------------------------------------
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Search in files for current word
nnoremap <leader>/ :silent execute "grep! " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>

" Find in files
command! -nargs=+ -complete=file -bar FindInFiles silent! grep! <args>|cwindow|redraw!

"------------------------------------------------------------------------------
" FZF
"------------------------------------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_tags_command = 'ctags -R --languages=python --exclude=node_modules --exclude=.venv'

"set rtp+=/opt/homebrew/opt/fzf - newer?

" Mapping to ensure FZF doesn't open in the NERDTree window
nnoremap <silent> <expr> <c-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <leader>f     :Rg<CR>
nnoremap <silent> <leader>b     :Buffers<CR>
nnoremap <silent> <leader>h     :History:<CR>
nnoremap <silent> <leader>h/    :History/<CR>
nnoremap <silent> <leader>m     :Marks<CR>
nnoremap <silent> <leader>T     :Tags<CR>
nnoremap <silent> <leader>t     :BTags<CR>

" WIP open FZF Files window if no file specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Files | endif
autocmd VimEnter * Files

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
" Open NERDTree if no files specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
"let g:vista_default_executive = 'coc'
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
" Mappings
"------------------------------------------------------------------------------
" Indentation
vnoremap < <gv
vnoremap > >gv

" Clear search highlights
nnoremap <silent> <esc> :noh<cr>

" Simpler Regexes
nnoremap / /\v
vnoremap / /\v
":cnoremap %s/ %s/\v

" Neovim terminal
"tnoremap <Esc> <C-\><C-n>

" nnoremap <F2> :call ReplaceIt()<cr> <C-o>
nnoremap \ :FindInFiles<SPACE>
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>l :NERDTreeFind<cr>
nnoremap <D-/> :NERDComToggleComment<cr>
nnoremap <F8> :Vista!!<cr>
nnoremap <leader>x Obreakpoint()<ESC>
"nnoremap <leader>t :Vista finder<cr>

" Fugitive
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :Gdiffsplit!<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gp :Git push<cr>
let g:fugitive_gitlab_domains = ['http://git.int.thisisglobal.com', 'http://gitlab01.lq.int.thisisglobal.com']

" Git Time Lapse
nmap <Leader>gt :GitTimeLapse<cr>

nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tv :TestVisit<CR>


" Keep window when deleting a buffer
"nnoremap <leader>bd :bp\|bd#<CR>

" pudb.vim
" nnoremap <F8> :PUDBToggleBreakPoint<CR>
" inoremap <F8> <ESC>:PUDBToggleBreakPoint<CR>

function! ReplaceIt()
    call inputsave()
    let replacement = input('Enter replacement:')
    call inputrestore()
    execute '%s//'.replacement.'/g'
endfunction
" source ~/.vim/python_ropevim.vim
