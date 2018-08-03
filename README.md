# source-insight
Let vim support file list, search history, tag list and neat interface

## Screenshot:

![example](https://github.com/susu9/source-insight/blob/master/screenshot-1.jpg)

## Hotkey
File list: 'gh'
> nnoremap gh :edit cscope.files<CR>

Search word: 'ctrl + f'
> nnoremap <C-f> :call SearchTag()<CR>

Search history: 'ctrl + h'
> nnoremap <C-h> :call SearchTagHis()<CR>

Repeat last search: 'ctrl + l'
> nnoremap <C-l> :call ReSearchTag()<CR>

window switch: 'gb'
> nnoremap gb :call BufSel()<CR>
