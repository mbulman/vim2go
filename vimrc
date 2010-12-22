"-------------------------------+
"
" Mike's .vimrc file
"
" It's cool.
"
"-------------------------------+

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Use Vim settings, rather than Vi settings
set nocp

" Turn on syntax highlighting
syntax on
" to remove the ^M from the end of files:
" http://www.vim.org/tips/tip.php?tip_id=26

set grepprg=greps
set encoding=utf8

" Allow for pasting without auto tabbing and commenting
set pastetoggle=<F12>

" Don't let files override my settings
"set modelines=0

" Formatting
set shiftwidth=4
set tabstop=4
set autoindent
set textwidth=100
set foldmethod=marker
set foldopen=hor,mark,search,tag,undo
set formatoptions=qroct
set nowrap
set expandtab
set smarttab
set tw=100

" Fix backspace not working
set bs=2

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Turn plugin features on
"filetype on
"filetype plugin on

" Misc
set showmode
set showcmd

" Make search case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" Turn off search highlighting
set nohls

" Make tab work sweetly (visual + tab/shift-tab)
vnoremap	<		<gv
vnoremap	>		>gv
vmap 		<tab>	>gv
vmap 		<s-tab>	<gv

" Turn of bracket matching in vim7
let loaded_matchparen = 1

" Autocorrect
abbreviate teh the

" Fold Display
set foldtext=MyFoldText()
function MyFoldText()
	let line = getline(v:foldstart)
	let prefix = ""
	while line[0] == "\t"
		let prefix = prefix . "    "
		let line = strpart(line, 1)
	endwhile
	while strpart(line,0,1) == " "
		let prefix = prefix . " "
		let line = strpart(line,1)
	endwhile

	let output = substitute(line, "[/\t\{}*#]", "", "g")
	while output[0] == "\ "
		let output = strpart(output, 1)
	endwhile
	return prefix . "+ " . output . "                                                                                                                                                                                                                      "
endfunction

" Misc Key Mappings
noremap <F5>	<C-W>k<C-W>_	" Go to prev window and maximize it
noremap <C-e>	<C-W>k<C-W>_	" Go to prev window and maximize it
noremap <F6>	<C-W>j<C-W>_	" Go to next window and maximize it
noremap <F7>	<C-W>=			" Make all windows equal
noremap <F8>	<C-W>_			" Maximize current window
noremap <F10>	:set tw=0 nowrap<CR>

noremap ;	:!php -l %<CR>
noremap \	:!java -jar js/bin/rhino.jar -f %<CR>
inoremap <C-c>	<c-p>
map ,# :s/^/#/<CR> 	" block commenting with #
map ,c :s/^#//<CR>

" Output shortcuts
iab VIM	<C-R>="// vim:ts=4:tw=100:fdm=marker:"
iab VIMM <C-R>="// vim:ts=4:sw=4:et:tw=100:fdm=marker:"
iab VIMC <C-R>="/* vim:ts=4:sw=4:et:tw=100:fdm=marker:\n/"
iab VIMT <C-R>="# vim:ts=2:sw=2:et:tw=100:fdm=marker:"

" Allow for shift-tab completion
inoremap <s-tab> <c-r>=InsertTabWrapper()<cr>
function InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction

" Show nice info in ruler
set ruler
"set laststatus=2 "i really like this but it messes up folds

" Use incremental searching
set incsearch

" tab navigation like firefox
nmap <F3> :tabprevious<cr>
nmap <F4> :tabnext<cr>
map <F3> :tabprevious<cr>
map <F4> :tabnext<cr>
imap <F3> <ESC>:tabprevious<cr>i
imap <F4> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr> 

" pig syntax highlighting
augroup filetypedetect 
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END 

" remove the underline from html links
hi Underlined cterm=bold ctermfg=5
hi Comment ctermfg=3
hi Folded ctermfg=3 ctermbg=none


"-------------------+
"     Php Stuff
"-------------------+

" Use php syntax check when doing :make
set makeprg=php\ -l\ %

" Use errorformat for parsing PHP error output
set errorformat=%m\ in\ %f\ on\ line\ %l

" Function name completion
set dictionary-=~/.vim/funclist.txt dictionary+=~/.vim/funclist.txt "http://lerdorf.com/funclist.txt
set complete-=k complete+=k

" Tag file for webmail checkouts
set tags=webmail_tags

" PhpDoc helpers
"inoremap <C-P> ^[:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

" Function prototype retrieval
inoremap <C-G> <ESC>:!/home/mbulman/src/phpm/phpm/phpm <C-R>=expand("<cword>")<CR><CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif 
