" Author: Rick Chang <chchang915@gmail.com>
" Source: https://github.com/susu9/source-insight

let s:mylist=[]
let s:lastIdx=-1

if !exists('g:cscope_search_history_size')
  let g:cscope_search_history_size=15
endif

function! cscope_search#AddMyHis(list, item)
  if len(a:list) && a:list[s:lastIdx] == a:item
    return
  endif

  let i = s:lastIdx + 1
  if i == g:cscope_search_history_size
    let i = 0
  endif

  if len(a:list) == g:cscope_search_history_size
    let a:list[i] = a:item
  else
    call add(a:list, a:item)
  endif
  let s:lastIdx = i
endfunction

function! cscope_search#ShowMyHis(list)
  echohl WarningMsg
  echo printf("%7s  %s\n", "#", "find history")
  echohl None

  let i = s:lastIdx
  let c = 1
  while i >= 0
    echo printf("%7d  %s\n", c, a:list[i])
    let i -= 1
    let c += 1
  endwhile

  let i = len(a:list) - 1
  while i > s:lastIdx
    echo printf("%7d  %s\n", c, a:list[i])
    let i -= 1
    let c += 1
  endwhile
endfunction

function! cscope_search#SearchTag()
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
    call cscope_search#AddMyHis(s:mylist, search_tag)
  catch
    echohl ErrorMsg
    echo v:exception
    echohl None
  endtry
endfunction

function! cscope_search#SearchTagLast()
  if s:lastIdx == -1
    echo "No history."
    return
  endif
  echo ""
  execute 'cs find e '.s:mylist[s:lastIdx]
endfunction

function! cscope_search#SearchTagHis()
  if s:lastIdx == -1
    echo "No history."
    return
  endif
  call cscope_search#ShowMyHis(s:mylist)
  call inputsave()
  let inIdx = input('Select:', '')
  call inputrestore()
  echo "\n"

  if inIdx <= 0 || inIdx > len(s:mylist)
    redraw
    return
  endif

  let i = s:lastIdx - (inIdx - 1)
  if i < 0
    let i += len(s:mylist)
  endif
  execute 'cs find e '.s:mylist[i]
  redraw
endfunction
