call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set nocompatible

" I can handle it on my own, thanks
filetype indent off

" When this is on, formatoptions gets clobbered by
" syntax files bundled with vim.
" Does disabling it break anything?
" Yes, NerdCommenter
filetype plugin on

colorscheme malachite
syntax on

" autocmd BufRead,BufNewFile TODO,*.TODO,*.todo set filetype=todo
autocmd BufNewFile,BufRead *.html set syntax=jinja
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" Hide splash screen
set shortmess+=I

" Pretty vertical split separator
set fillchars=vert:│

" Fix clipboard?
set mouse=r
" set clipboard=unnamedplus

set number
set hidden
set ignorecase
set smartcase
set hlsearch
set showcmd
set noswapfile
set nojoinspaces
set noincsearch
set laststatus=1

set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=3

set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc,*.egg-info/

set backupdir=~/.vim/tmp

" Better listchars (maintains tab width)
set listchars=tab:>-,trail:-

" Allow backspacing over everything in insert mode.
" I guess this isn't in some systems' default vimrc.
set backspace=indent,eol,start

" Disable incredibly annoying automatic comment leader insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable obnoxious bold/underlining when writing HTML
let html_no_rendering=1

" Hardcore mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Hacky hacks to collapse/expand CSS rules
" Dang, these collide with NERDCommenter D:
" map <Leader>cc va{Jhx
" map <Leader>ce V:!csstidy - --silent=true<CR>f{vi{>

let g:netrw_banner = 0

" gist.vim: List private gists
let g:gist_show_privates = 1

" surround.vim: Blast away the default 's' mapping
nmap s   <Plug>Ysurround
nmap S   <Plug>YSurround
nmap ss  <Plug>Yssurround
nmap Ss  <Plug>YSsurround
nmap SS  <Plug>YSsurround

" sideways.vim: For flippin' parameters around
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>

" goyo.vim: gray is more subtle than black
let g:goyo_bg = 8

" Don't open man pages, please
nmap K k

" Sudo-and-write, for when you forget to sudo
cmap W! w !sudo tee % >/dev/null

function! ToggleColorColumn()
    if &colorcolumn
        set colorcolumn=
    else
        set colorcolumn=78
    endif
endfunction

" Misc bindings for convenience
let mapleader=","
map <Leader>n :noh<CR>
map <Leader>l :call ToggleColorColumn()<CR>
map <Leader>g :Goyo<CR>

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

autocmd FileType go nmap <Leader>r <Plug>(go-run)
autocmd FileType go nmap <Leader>m <Plug>(go-metalinter)

let g:go_fmt_command="goimports"
