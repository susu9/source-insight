" Author: Rick Chang <chchang915@gmail.com>
" Source: https://github.com/susu9/source-insight

let s:mylist=[]
let s:wIdx=0

if !exists('g:cscope_search_history_size')
  let g:cscope_search_history_size=15
endif

function! AddMyHis(list, item)
    if len(a:list) && a:list[s:wIdx - 1] == a:item
        return
    endif
	if len(a:list) == g:cscope_search_history_size
		let a:list[s:wIdx] = a:item
	else
		call add(a:list, a:item)
	endif
	let s:wIdx += 1
	if s:wIdx == g:cscope_search_history_size
		let s:wIdx = 0
	endif
endfunction

function! ShowMyHis(list)
	echohl WarningMsg
	echo printf("%7s  %s\n", "#", "find history")
	echohl None

    let i = s:wIdx
    let c = 1
    while i < len(a:list)
		echo printf("%7d  %s\n", c, a:list[i])
        let i += 1
        let c += 1
    endwhile

    let i = 0
    while i < s:wIdx
		echo printf("%7d  %s\n", c, a:list[i])
        let i += 1
        let c += 1
    endwhile
endfunction

function! SearchTag()
	call inputsave()
	let search_tag = input('find:', '', 'tag')
	call inputrestore()
	echo "\n"
	if search_tag == ''
		redraw
		return
	endif
	try
		execute 'cs find e '.search_tag
		call AddMyHis(s:mylist, search_tag)
	catch
		echohl ErrorMsg
		echo v:exception
		echohl None
	endtry
endfunction

function! SearchTagLast()
	if empty(s:mylist)
		echo printf("No history.")
        return
    endif
	echo ""
	execute 'cs find e '.s:mylist[s:wIdx-1]
endfunction

function! SearchTagHis()
	call ShowMyHis(s:mylist)
	call inputsave()
	let histag = input('Select:', '')
	call inputrestore()
	echo "\n"
	if histag > 0 && histag <= len(s:mylist)
		execute 'cs find e '.s:mylist[histag - 1]
        return
	endif
	redraw
endfunction
