" Author: Rick Chang <chchang915@gmail.com>
" Source: https://github.com/susu9/source-insight

let s:mylist=[]
let s:lastIdx=-1

function! cscope_search#AddMyHis(list, item)
  if len(a:list) && a:list[s:lastIdx] == a:item
    return
  endif

  let i = (s:lastIdx + 1) % g:cscope_search_history_size
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

  let len = len(a:list)
  let i = s:lastIdx + len
  let c = 1
  while c <= len
    echo printf("%7d  %s\n", c, a:list[i % len])
    let i -= 1
    let c += 1
  endwhile
endfunction

function! s:_SearchTag(tag)
  let ret = 1
  let fakeEdit = 0
  if g:cscope_search_prevent_jump && &cscopequickfix =~ 'e-' && &switchbuf !~ 'split\|newtab'
    try
      execute 'silent normal! ii'
      let fakeEdit = 1
    catch
    endtry
  endif

  try
    execute 'cs find e' a:tag
  catch /^Vim(cscope):E37/
    " Ignore No write since last change (add ! to override)
  catch
    redraw
    echohl ErrorMsg
    echo v:exception
    echohl None
    let ret = 0
  endtry

  if fakeEdit
    execute 'silent normal! u'
  endif
  return ret
endfunction

function! cscope_search#SearchTag()
  call inputsave()
  let tag = input('find:', '', 'tag')
  call inputrestore()
  echo "\r"
  echo ""
  if tag == ''
    return
  endif
  if s:_SearchTag(tag)
    call cscope_search#AddMyHis(s:mylist, tag)
  endif
endfunction

function! cscope_search#SearchTagLast()
  if s:lastIdx == -1
    echohl WarningMsg
    echo "No history."
    echohl None
    return
  endif
  echo ""
  call s:_SearchTag(s:mylist[s:lastIdx])
endfunction

function! cscope_search#SearchTagHis()
  if s:lastIdx == -1
    echohl WarningMsg
    echo "No history."
    echohl None
    return
  endif
  call cscope_search#ShowMyHis(s:mylist)
  call inputsave()
  let inIdx = input('Select:', '')
  call inputrestore()
  echo "\r"

  let len = len(s:mylist)
  if inIdx <= 0 || inIdx > len
    return
  endif

  let i = (s:lastIdx - (inIdx - 1) + len) % len
  call s:_SearchTag(s:mylist[i])
  redraw
endfunction
