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
set textwidth=80 colorcolumn=120
set cursorline

" colors
colorscheme pablo
hi CursorLine cterm=bold ctermbg=235 " Overwrite cursor line style
hi ColorColumn ctermbg=202 cterm=none

" keybindings
let mapleader=","
nmap <leader>k :FufFile<CR>
