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

" Add support for machine specific dotfile
" By default this is machine.vim in the same dir as init.vim
ru machine.vim

" Show trailing whitepace and spaces before a tab:
hi link ExtraWhitespace ErrorMsg
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show tabs
set list
set listchars=tab:>-

" Add C++ line length guide
au FileType cpp,hpp setl cc=120

" Attempt to disable automatic comment continuation
au BufNewFile,BufRead * setl fo-=c fo-=r fo-=o

" Select all
nmap <c-a> ggVG

" C++ or CMakeLists file two-space indents
au FileType cpp,hpp setl tabstop=2
au BufEnter CMakeLists.txt setl tabstop=2

" Paste mode hotkey
set pastetoggle=<F2>

" Paste yank in insert and command mode
map! <c-r> <c-r>"

" Yank to EOL, but not CR
nor Y v$hy

" Insert newlines
nn <c-k> mxo<esc>`x
nn <c-j> mxO<esc>`x

" Set persistent status line
set laststatus=2

" Allow searching of a visual selection with //
vn // y/\V<c-r>"<cr>

" Otherwise // clears the search
nn // :let @/ = ""<cr>

" Allow saving of files as sudo when I forget to start vim using sudo.
cno w!! w !sudo tee > /dev/null %

" Warn on file change
au FileChangedShell * echo "Warning: File changed on disk"

" Set default explorer view
let g:netrw_liststyle = 3

" Enable XML highlighting for .launch files
au BufEnter *.launch setl syntax=xml

" Faster tab switching
nor <c-l> gt
nor <c-h> gT

" Faster split switching
map <space> <c-w><c-w>

" Enable insert mode arrows
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>

" Fix YAML and vim autospacing
au FileType yaml,vim setl ts=2 sts=2 sw=2 expandtab

" Some fun command maps
com! W w
com! Q q
com! Wq wq
com! WQ wq
com! V tabe ~/.config/nvim/init.vim
com! M tabe ~/.config/nvim/machine.vim
com! S source ~/.config/nvim/init.vim
com! WS w | S
com! Ws w | S
com! E Explore

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
fu! GetGitDir()
  let dir = systemlist('git rev-parse --show-toplevel')[0]
  if dir =~? "^fatal: Not a git repository"
    return '.'
  else
    return dir
  endif
endf
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(GetGitDir(), <bang>0)
nn <c-p> :GFiles --exclude .pyc<cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nor F f
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
ino <C-c> <Esc><Esc>

" Far
nmap <c-f> :Farp<CR>
vmap <c-f> :Farp<CR>
au FileType far_vim map <buffer> <c-f> :Fardo<CR>:q<CR>
