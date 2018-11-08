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
filetype plugin indent on

" Add support for machine specific dotfile
" By default this is machine.vim in the same dir as init.vim
ru machine.vim

" Don't yank on paste, replace, x or s
xn p "_dP
xn c "_c
nn c "_c
nn C "_C
nn x "_x
nn s "_s

" Disable C/C++ one-line auto-comment and set tabstop
au FileType h,hpp,c,cpp setlocal comments-=:// comments+=f:// tabstop=2

" Show trailing whitepace and spaces before a tab
hi link ExtraWhitespace ErrorMsg
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Removes trailing spaces
fu! RemoveTrailingWhitespace()
  %s/\s*$//
  ''
endf
com! TrimWhitespace call RemoveTrailingWhitespace()

" Show tabs
set list
set listchars=tab:>-

" Add C++ line length guide
au FileType cpp,hpp setl cc=120

" Select all
nm <c-a> ggVG

" C++ or CMakeLists file two-space indents
au FileType cpp,hpp setl tabstop=2
au BufEnter CMakeLists.txt setl tabstop=2

" Paste mode hotkey
set pastetoggle=<F2>

" Paste yank in insert and command mode
map! <c-r> <c-r>"

" Yank to EOL, but not cr
nor Y v$hy

" Insert newlines
nn <c-k> mxo<esc>`x
nn <c-j> mxO<esc>`x

" Split lines
nn <s-k> xmxi<cr><esc>`x

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
au BufEnter *.launch,*.test setl syntax=xml

" Faster tab switching
nor <c-l> gt
nor <c-h> gT

" Faster split switching
map <space> <c-w><c-w>

" Enable insert mode arrows
im <c-h> <Left>
im <c-j> <Down>
im <c-k> <Up>
im <c-l> <Right>

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
Plug 'machakann/vim-highlightedyank'
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
com! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(GetGitDir(), <bang>0)
nn <c-p> :GFiles --exclude .pyc<cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nor F f
map f <Plug>(easymotion-overwin-f)
vm f <Plug>(easymotion-bd-f)
im <c-f> <c-o>f
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
let g:NERDCreateDefaultMappings = 0
let g:NERDRemoveAltComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//' }, 'cpp': { 'left': '//' },
                             \ 'h': { 'left': '//' }, 'hpp': { 'left': '//' },
                             \ 'asm': { 'left': '#' }}
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_h = 1
let g:NERDAltDelims_cpp = 1
let g:NERDAltDelims_hpp = 1
let g:NERDAltDelims_asm = 1
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
au FileType far_vim map <buffer> <c-f> :Fardo<cr>:q<cr>
let g:far#auto_write_replaced_buffers = 0

fu! FarPromptBuffer(rngmode, rngline1, rngline2, ...) abort range "{{{
  call far#tools#log('============ FAR PROMPT ================')

  let pattern = input('Search in buffer (pattern): ', '', 'customlist,far#FarSearchComplete')
  call far#tools#log('>pattern: '.pattern)
  if empty(pattern)
    call far#tools#echo_err('No pattern')
    return
  endif

  let replace_with = input('Replace with: ', '', 'customlist,far#FarReplaceComplete')
  call far#tools#log('>replace_with: '.replace_with)

  let far_params = {
    \   'pattern': pattern,
    \   'replace_with': replace_with,
    \   'file_mask': '%',
    \   'range': a:rngmode == -1? [-1,-1] : [a:rngline1, a:rngline2],
    \   }

  call far#find(far_params, a:000)
endf

com! -complete=customlist,far#FarArgsComplete -nargs=* -range=-1 FarpBuf
  \ call FarPromptBuffer(<count>,<line1>,<line2>,<f-args>)
"}}}

nm <c-f> :FarpBuf<cr>
vm <c-f> :FarpBuf<cr>

fu! ActiveBuffers()
  redir => bufs
  silent execute 'ls a'
  redir END
  let bufs = split(bufs)
  let paths = []
  for str in bufs
    if match(str, '".*"') >= 0
      let paths = add(paths, str[1:-2])
    endif
  endfor
  return join(paths, ' ')
endf

fu! FarPromptActiveBuffers(rngmode, rngline1, rngline2, ...) abort range "{{{
  call far#tools#log('============ FAR PROMPT ================')

  let pattern = input('Search in active buffers (pattern): ', '', 'customlist,far#FarSearchComplete')
  call far#tools#log('>pattern: '.pattern)
  if empty(pattern)
    call far#tools#echo_err('No pattern')
    return
  endif

  let replace_with = input('Replace with: ', '', 'customlist,far#FarReplaceComplete')
  call far#tools#log('>replace_with: '.replace_with)

  let far_params = {
    \   'pattern': pattern,
    \   'replace_with': replace_with,
    \   'file_mask': ActiveBuffers(),
    \   'range': a:rngmode == -1? [-1,-1] : [a:rngline1, a:rngline2],
    \   }

  call far#find(far_params, a:000)
endf

com! -complete=customlist,far#FarArgsComplete -nargs=* -range=-1 FarpABuf
  \ call FarPromptActiveBuffers(<count>,<line1>,<line2>,<f-args>)
"}}}

nm <c-b> :FarpABuf<cr>
vm <c-b> :FarpABuf<cr>

" Highlighted Yank
let g:highlightedyank_highlight_duration = 500
