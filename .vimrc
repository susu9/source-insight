"---- Check & Install plugin manager ----
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

"---- Config plugin ----
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentLine'
"Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'susu9/cscope_search'
"Plug 'ackyshake/VimCompletesMe'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
call plug#end()

"--- Supertab ---
let g:SuperTabDefaultCompletionType = "<c-n>"

"---- Ale ----
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

"--- vim-signify ---
nmap fn <plug>(signify-next-hunk)
nmap fm <plug>(signify-prev-hunk)

"---- Tagbar ----
let g:tagbar_left=1
autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd BufEnter * nested :call tagbar#autoopen(0)
autocmd VimEnter * :TagbarOpen
autocmd BufEnter cscope.files :set ro

"---- gruvbox ----
set bg=dark
colorscheme gruvbox

"---- vim-polyglot ----
syntax on

"---- vim-gitgutter ----
"autocmd BufWritePost * :GitGutterAll

"---- cscope-search ----
autocmd VimEnter * :copen 6 | :wincmd p
set cscopequickfix=s-,f-,g-,c-,d-,i-,t-,e-
nnoremap <C-f> :CscopeSearch<CR>
nnoremap <C-h> :CscopeSearchHistory<CR>
nnoremap <C-l> :CscopeSearchLast<CR>
autocmd QuickFixCmdPost [^l]* nested botright cwindow 6
"autocmd QuickFixCmdPost    l* nested botright lwindow 6
nnoremap fj :cn<CR>
nnoremap fk :cp<CR>
"set switchbuf=uselast

"---- ctrlp ----
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'cat cscope.files'
nnoremap <C-b> :CtrlPBuffer<CR>

"---- General ----
set backspace=indent,eol,start
set laststatus=1
set showmatch
set autoindent
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set ruler
set showmode
set cmdheight=1
set cursorline
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set relativenumber
set colorcolumn=80
set ut=1000

"---- Editor map ----
noremap <C-j> 3<C-e>
noremap <C-k> 3<C-y>
nnoremap <C-w>f :vertical wincmd f<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <F10> :call SwitchTab()<CR>
inoremap jj <Esc>
nnoremap fc :noh<CR>
nnoremap ft :vsp cscope.files<CR>
nnoremap fh :edit cscope.files<CR>

"---- Commands ----
command! GetPath :echo expand('%:p')

"---- Auto Commands ----
autocmd FileType cpp autocmd VimEnter * :set makeprg=g++\ -std=c++11\ -o\ %<\ %
"autocmd FileType python,c,cpp,javascript,java autocmd BufEnter * :set colorcolumn=80
"autocmd FileType html,scss,javascript,vim autocmd BufEnter * :set expandtab tabstop=2 shiftwidth=2 softtabstop=2

if !empty(glob('~/.rickch.vimrc'))
source ~/.rickch.vimrc
endif
