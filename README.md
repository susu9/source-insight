# source-insight
Let vim support file list, search history, tag list and neat interface

## Hotkey
Search word: 'ctrl + f'
> nnoremap <C-f> :call SearchTag()<CR>

Search history: 'ctrl + h'
> nnoremap <C-h> :call SearchTagHis()<CR>

Repeat last search: 'ctrl + l'
> nnoremap <C-l> :call SearchTagLast()<CR>

window switch: 'gb'
> nnoremap gb :call BufSel()<CR>
