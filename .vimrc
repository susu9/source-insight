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
Plug 'airblade/vim-gitgutter'
call plug#end()

"---- Tagbar ----
let g:tagbar_left=1
autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd VimEnter cscope.files :TagbarOpen

"---- gruvbox ----
set bg=dark
colorscheme gruvbox

"---- vim-polyglot ----
syntax on

"---- vim-gitgutter ----
autocmd BufWritePost * :GitGutterAll

"---- cscope-search ----
autocmd VimEnter cscope.files :copen 6 | :wincmd p
set cscopequickfix=s-,f-,g-,c-,d-,i-,t-,e-,a-
nnoremap <C-f> :call cscope_search#SearchTag()<CR>
nnoremap <C-h> :call cscope_search#SearchTagHis()<CR>
nnoremap <C-l> :call cscope_search#SearchTagLast()<CR>
autocmd QuickFixCmdPost [^l]* nested cwindow 6
autocmd QuickFixCmdPost    l* nested lwindow 6
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
set switchbuf=uselast

"---- General ----
set backspace=indent,eol,start
set laststatus=1
set showmatch
set autoindent
set number
set hlsearch
set incsearch
set ruler
set showmode
set cmdheight=1
set cursorline
set expandtab tabstop=4 shiftwidth=4 softtabstop=4

"---- Editor map ----
noremap <C-j> 3<C-e>
noremap <C-k> 3<C-y>
nnoremap <C-w>f :vertical wincmd f<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <F10> :call SwitchTab()<CR>
inoremap jj <Esc>
nnoremap gt :vsp cscope.files<CR>
nnoremap gh :edit cscope.files<CR>
nnoremap gb :call BufSel()<CR>

"---- Commands ----
command! GetPath :echo expand('%:p')

"---- Auto Commands ----
autocmd FileType cpp autocmd VimEnter * :set makeprg=g++\ -std=c++11\ -o\ %<\ %
autocmd FileType python,c,cpp,javascript,java autocmd VimEnter * :set colorcolumn=80
autocmd FileType html,scss,javascript,vim autocmd BufEnter * :set expandtab tabstop=2 shiftwidth=2 softtabstop=2
