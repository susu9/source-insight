set laststatus=1
set showmatch
"set autoindent
set nu
set hlsearch
set incsearch
set ruler
set showmode
set cindent
set cmdheight=1
syntax on
set cursorline
set ut=500
"--------------------------------------- Color scheme -------------------------------------------
set bg=dark
set t_Co=256
hi StatusLine ctermbg=white ctermfg=22
hi StatusLineNC ctermbg=238 ctermfg=black
hi VertSplit ctermbg=34 ctermfg=black
hi FoldColumn ctermfg=34 ctermbg=black
hi MyTagListFileName ctermfg=34 ctermbg=black
hi MyTagListTagName ctermfg=34 ctermbg=236
hi MyTagListtitle ctermfg=34
hi Cursorline ctermbg=236 cterm=bold term=bold 
" Tab
hi TabLineFill ctermfg=black ctermbg=black
hi TabLine ctermfg=white ctermbg=238 cterm=bold
hi TabLineSel ctermfg=white ctermbg=34
hi Pmenu ctermfg=white ctermbg=238
hi PmenuSel ctermfg=238 ctermbg=white
hi Comment ctermfg=darkgreen
highlight ColorColumn ctermbg=236
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.java,*.js :set colorcolumn=80
"Cscope
hi ModeMsg ctermfg=34
"--------------------------------------- Taglist -------------------------------------------
autocmd BufWritePost *.c,*.cpp,*.h,*.java,*.js :TlistUpdate
autocmd VimEnter cscope.files :TlistToggle
let Tlist_Exit_OnlyWindow=1
let Tlist_Display_Tag_Scope=0
let Tlist_Auto_Open=1
let Tlist_Show_One_File=1
let tlist_cpp_settings = 'c++;n:namespace;d:macro;t:typedef;' .
                             \ 'c:class;g:enum;s:struct;u:union;f:function'
let tlist_c_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;' .
                           \ 'f:function'
let tlist_java_settings = 'java;p:package;c:class;i:interface;' .
                              \ 'g:enum;m:method'
" Default tab setting --------------------------------------------------------------------
if match(getcwd(), "\\cKernel") > 0
    set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
else
    set expandtab tabstop=4 shiftwidth=4 softtabstop=4
endif
autocmd FileType javascript set expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 softtabstop=4
"---------------------------------- Key mapping -------------------------------------------
set makeprg=g++\ -std=c++11\ -o\ %<\ %
map <F7> :tabp<CR>
map <F8> :tabn<CR>
"nnoremap <silent> <F7> :hi Normal ctermfg=black ctermbg=white<CR>:hi Cursorline ctermbg=white cterml=reverse<CR>
nnoremap <C-f> :call SearchTag()<CR>
nnoremap <C-h> :call SearchTagHis()<CR>
nnoremap <C-l> :call ReSearchTag()<CR>
nnoremap <C-n> :tnext<CR>
nnoremap <C-p> :tprevious<CR>
command! Path :echo expand('%:p')
map <C-j> 3j
map <C-k> 3k
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <S-j> 3<C-e>
nnoremap <S-k> 3<C-y>
nnoremap <C-w>f :vertical wincmd f<CR>
nnoremap <F5> :!csmgr -f<CR> :cs reset<CR>
nnoremap <silent> <F9> : TlistToggle<CR>
nnoremap <silent> <F10> :call SwitchTab()<CR>
inoremap jj <Esc>
nnoremap gh :edit cscope.files<CR>
nnoremap gb :call BufSel()<CR>
