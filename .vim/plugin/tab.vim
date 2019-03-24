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

