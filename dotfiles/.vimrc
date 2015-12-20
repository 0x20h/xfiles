" pathogen
execute pathogen#infect()
filetype plugin indent on

" backups
set backupdir=~/.vim/backup,/tmp,.
set directory=~/.vim/backup,/tmp,.

" show whitespace chars
set listchars=tab:▸\ ,eol:¬
set list

" indents
set ts=4 sw=4 smartindent

" searching
set hlsearch incsearch noignorecase

" misc
set number
syn on
set backspace=2
set textwidth=120 colorcolumn=120
set cursorline
set foldenable foldlevel=1
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set showmode
set wildmenu

" colors
colorscheme pablo
hi CursorLine cterm=bold ctermbg=235 " Overwrite cursor line style
hi ColorColumn ctermbg=202 cterm=none
hi Folded cterm=none ctermfg=white ctermbg=black
hi PMenu cterm=none ctermbg=black ctermfg=lightgrey
hi PMenuSel cterm=bold ctermbg=239 ctermfg=white
" colors.diff
hi DiffAdd term=bold ctermbg=22 ctermfg=255
hi DiffChange term=bold ctermfg=16 ctermbg=220
hi DiffDelete term=bold ctermfg=247 ctermbg=196
hi DiffText term=reverse cterm=bold ctermfg=white


" keybindings
let mapleader=","

" vim-fuzzyfinder
nmap <leader>k :FufFile<CR>
nmap <leader>l :FufBufferTag<CR>
nmap <C-a> :FufCoverageFile<CR>

" nerdtree
let g:NERDTreeWinSize=50
map <F2> :NERDTreeToggle<cr>

" next/prev buffer
nnoremap <ENTER> :bn<CR>
" ENTER behavior in normal mode
nnoremap <C-j> i<CR><ESC>

" language specific settings

" PHP
let php_folding=1
let php_htmlInStrings=1
let php_sql_query=1
let php_noShortTags=1

" allow a project-wise vimrc to overwrite defaults
if !exists("*LoadProjectSettings")
	function LoadProjectSettings()
		if (filereadable('./vimrc'))
			:source ./vimrc
		endif
	endfunction
endif

autocmd BufReadPre * :call LoadProjectSettings()
