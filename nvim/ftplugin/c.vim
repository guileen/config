setlocal foldmethod=syntax
" Ignore too long too short folding
if line('$') > 150 && line('$') < 10000
	set foldenable
endif
