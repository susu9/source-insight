
if !exists('g:cscope_search_history_size')
  let g:cscope_search_history_size=15
endif

if !exists('g:cscope_search_prevent_jump')
  let g:cscope_search_prevent_jump=1
endif

command! CscopeSearch call cscope_search#SearchTag()
command CscopeSearchHistory call cscope_search#SearchTagHis()
command CscopeSearchLast call cscope_search#SearchTagLast()
