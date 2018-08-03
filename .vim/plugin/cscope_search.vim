if has("cscope")

let s:mylist=[1]
let s:myHistMax=20

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

endif
