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
"highlight Cursor ctemfg=white ctermbg=black
"highlight iCursor ctermfg=white ctermbg=steelblue
hi Pmenu ctermfg=white ctermbg=238
hi PmenuSel ctermfg=238 ctermbg=white
hi Comment ctermfg=darkgreen
"Column margin line ---
"highlight OverLength ctermbg=red ctermfg=white
"autocmd BufNewFile,BufRead *.c,*.cpp,*.h :match OverLength /\%>80v.\+/
highlight ColorColumn ctermbg=236
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.java :set colorcolumn=80
"Cscope ---
hi ModeMsg ctermfg=34
"--------------------------------------- Taglist -------------------------------------------
autocmd BufWritePost *.c,*.cpp,*.h,*.java :TlistUpdate
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
"--------------------------------------- Function -------------------------------------------
let s:mylist=[1]
let s:myHistMax=20
function! Foo()
	call AddMyHis(s:mylist, len(s:mylist))
	call ShowMyHis(s:mylist)
endfunction
function! AddMyHis(list, item)
	if len(a:list) > s:myHistMax
		let a:list[a:list[0]] = a:item
		let a:list[0] = a:list[0] + 1
	else
		call add(a:list, a:item)
	endif
	if a:list[0] > s:myHistMax
		let a:list[0] = 1
	endif
endfunction
function! ShowMyHis(list)
	let c = 1
	echohl WarningMsg
	echo printf("%7s  %s\n", "#", "find history")
	echohl None
	for i in a:list[a:list[0]:-1]
		echo printf("%7d  %s\n", c, i)
		let c = c + 1
	endfor
	if a:list[0] > 1
		for i in a:list[1:a:list[0]-1]
			echo printf("%7d  %s\n", c, i)
			let c = c + 1
		endfor
	endif
endfunction
function! SearchTag()
	call inputsave()
	let search_tag = input('find:', '', 'tag')
	call inputrestore()
	echo "\n"
	try
		execute 'cs find e '.search_tag
		call AddMyHis(s:mylist, search_tag)
	catch
		echohl ErrorMsg
		echo v:exception
		echohl None
	endtry
"	call histadd("cmd", 'cs find e '.search_tag)
endfunction
function! ReSearchTag()
	if s:mylist[0] == 1
		execute 'cs find e '.s:mylist[-1]
	else
		execute 'cs find e '.s:mylist[s:mylist[0]-1]
	endif
endfunction
function! SearchTagHis()
	call ShowMyHis(s:mylist)
	call inputsave()
	let histag = input('Select:', '')
	call inputrestore()
	echo "\n"
	if histag > 0 && histag < len(s:mylist)
		execute 'cs find e '.s:mylist[histag]
	else
		redraw
	endif
endfunction
function! SwitchTab()
	if &tabstop == 8 
		echo 'set expandtab tabstop=4 shiftwidth=4 softtabstop=4'
		set expandtab tabstop=4 shiftwidth=4 softtabstop=4
	elseif &tabstop == 4
		echo 'set expandtab tabstop=2 shiftwidth=2 softtabstop=2'
		set expandtab tabstop=2 shiftwidth=2 softtabstop=2
	else
		echo 'set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8'
		set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
	endif
endfunction
"---------------------------------- Key mapping -------------------------------------------
map <F7> :tabp<CR>
map <F8> :tabn<CR>
"nnoremap <silent> <F7> :hi Normal ctermfg=black ctermbg=white<CR>:hi Cursorline ctermbg=white cterml=reverse<CR>
nnoremap <C-f> :call SearchTag()<CR>
nnoremap <C-\>h :call SearchTagHis()<CR>
nnoremap <C-l> :call ReSearchTag()<CR>
nnoremap <C-n> :tnext<CR>
nnoremap <C-p> :tprevious<CR>
command Path :echo expand('%:p') 
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
