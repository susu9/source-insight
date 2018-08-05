
function! BufSel()
	let cur = bufnr("%")
	let alt = bufnr("#")
	let n = bufnr("$")
	for i in range(1, n)
		if (!bufexists(i) || bufname(i) == "__Tag_List__")
			continue
		endif
		if (i == cur)
			let word = "+"
		elseif (i == alt)
			let word = "-"
		else
			let word = " "
		endif
        	"echo word . i . ": ". bufname(i)
		echo printf("%s%2d: %s", word, i, bufname(i))
	endfor
	if (n <= 1)
		return
	endif
	let bn = input("To: ")
	if(strlen(bn) != 0)
		execute ":buffer ". bn
	endif
endfunction

