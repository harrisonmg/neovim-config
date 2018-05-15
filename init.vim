" General config
set noshowmode
set number
set ruler
set ignorecase
set encoding=utf8
set expandtab
set shiftwidth=0
set tabstop=4
set cursorline

" Disable automatic comment continuation
au BufNewFile,BufRead * setlocal fo-=c fo-=r fo-=o

" Select all
nmap <c-a> ggVG

" C++ or CMakeLists file two-space indents
au FileType cpp,hpp setlocal tabstop=2
au BufEnter CMakeLists.txt setlocal tabstop=2

" Paste mode hotkey
set pastetoggle=<F2>

" Paste yank in insert mode
imap <c-r> <c-r>"

" Yank to EOL, but not CR
noremap Y v$hy

" Insert newlines
nnoremap <c-k> mxo<esc>`x
nnoremap <c-j> mxO<esc>`x

" Set persistent status line
set laststatus=2

" Allow searching of a visual selection with //
vnoremap // y/\V<c-r>"<cr>

" Otherwise // clears the search
nnoremap // :let @/ = ""<cr>

" Allow saving of files as sudo when I forget to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" Warn on file change
au FileChangedShell * echo "Warning: File changed on disk"

" Set default explorer view
let g:netrw_liststyle = 3

" Enable XML highlighting for .launch files
au BufEnter *.launch setlocal syntax=xml

" Faster tab switching
noremap <c-l> gt
noremap <c-h> gT

" Faster split switching
map <space> <c-w><c-w>

" Enable insert mode arrows
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>

" Fix YAML autospacing
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Some fun command maps
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! V tabe ~/.config/nvim/init.vim
command! S source ~/.config/nvim/init.vim
command! WS w | S
command! Ws w | S
command! E Explore

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'vimjas/vim-python-pep8-indent'
Plug 'brooth/far.vim'
call plug#end()

" Seoul256 colorscheme
hi normal guibg=NONE ctermbg=NONE
let g:seoul256_background = 236
set background=dark
colo seoul256
hi LineNr ctermbg=NONE
hi VertSplit ctermbg=NONE cterm=NONE
set fillchars+=vert:\ 

" FZF
nnoremap <c-p> :GFiles<cr>
nnoremap <c-n> :Files<cr>

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map f <Plug>(easymotion-overwin-f)
vmap f <Plug>(easymotion-bd-f)
imap <c-f> <c-o>f
hi link EasyMotionTarget Exception
hi link EasyMotionIncCursor Search

" Lightline
let g:lightline = { 'colorscheme': 'seoul256' }
let g:lightline.tab_component_function = {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': '' }

" NERD Commenter
if has('win32')
    map <c-/> <plug>NERDCommenterToggle
else
    map <c-_> <plug>NERDCommenterToggle
endif

" ALE
let g:ale_lint_delay = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
inoremap <C-c> <Esc><Esc>

" Far
nmap <c-f> :Farp<CR>
vmap <c-f> :Farp<CR>
au FileType far_vim map <buffer> <c-f> :Fardo<CR>:q<CR>
