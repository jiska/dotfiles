set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,utf-16,japan

set backspace=2
set tabstop=2
set shiftwidth=4
set expandtab

set list
set number
set ruler
set smartindent
set showmatch
set showmode

set ignorecase

highlight tabs ctermbg=green guibg=green

"check php syntax 
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

"pathogen
"http://www.vim.org/scripts/script.php?script_id=2332
call pathogen#runtime_append_all_bundles()
