" General config
set noshowmode
set number
set ruler
set encoding=utf8
set expandtab
set shiftwidth=0
set tabstop=4
set cursorline
set linebreak
set mouse=a
set visualbell
filetype plugin indent on

" Disable mouse clicks
:nm <LeftMouse> <nop>
:im <LeftMouse> <nop>
:vm <LeftMouse> <nop>
:nm <RightMouse> <nop>
:im <RightMouse> <nop>
:vm <RightMouse> <nop>

" Save
nn <c-s> :w<cr>

" New tab
nn <c-t> :tabe<cr>

" Copy visual selection to clipboard (WSL)
vn <c-y> :w !clip.exe<cr><cr>

" Disable Ex mode
map q: <Nop>
nn Q <nop>

" Ctrl-c as Escape
ino <c-c> <Esc>

" Open help in new tab instead of split
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'

" Don't unindent on #
set cinkeys-=0#

" Z FOR ONE THING AND ONE THING ONLY
map z zz

" Don't yank on paste, replace, x or s
vn p "_dP

vn c "_c
vn C "_C
vn x "_x
vn s "_s

nn c "_c
nn C "_C
nn x "_x
nn s "_s

" Disable one-line auto-comment
au filetype h,hpp,c,cpp,javascript,java setl comments-=:// comments+=f:// cc=120

" Show trailing whitepace and spaces before a tab
hi link ExtraWhitespace ErrorMsg
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Close buffer
nm <c-w> :q<cr>

" Fucking freak
nm <c-m-w> :q!<cr>

" Faster split switching
nn <space> <c-w><c-w>

" Show tabs
set list
set listchars=tab:>-

" Select all
nm <c-a> ggVG

" C++ or CMakeLists file two-space indents
au BufEnter CMakeLists.txt setl tabstop=2

" Paste mode toggle hotkey
set pastetoggle=<f2>

" Line number toggle hotkey
nn <f3> :set invnumber<cr>

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

" Faster tab switching and rearranging
nor <c-l> gt
nor <c-h> gT
nor <c-m-l> :tabm +1<cr>
nor <c-m-h> :tabm -1<cr>

" Enable insert mode arrows
im <c-h> <Left>
im <c-j> <Down>
im <c-k> <Up>
im <c-l> <Right>

" Fix YAML and vim autospacing
au filetype yaml,vim setl ts=2 sts=2 sw=2 expandtab

" Some fun command maps
com! W w
com! Q q
com! Wq wq
com! WQ wq
com! V tabe ~/dotfiles/init.vim
com! M tabe ~/.config/nvim/machine.vim
com! S source ~/.config/nvim/init.vim
com! WS w | S
com! Ws w | S
com! E tabe | Explore

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'brooth/far.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'harrisonmg/vim-hexdec'
Plug 'vim-scripts/renumber.vim'
Plug 'easymotion/vim-easymotion'
Plug 'nessss/vim-gml'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'Shougo/echodoc.vim'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

" Seoul256 colorscheme
hi normal guibg=NONE ctermbg=NONE
let g:seoul256_background = 236
set background=dark
colo seoul256
hi EndOfBuffer ctermfg=bg guifg=bg
hi LineNr ctermbg=NONE
hi VertSplit ctermbg=NONE cterm=NONE
set fillchars+=vert:\  " <- don't delete that whitespace!

" FZF
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nn <c-g> :Windows<cr>
fu! GetGitDir()
  let dir = systemlist('git rev-parse --show-toplevel')[0]
  if dir =~? "^fatal: Not a git repository"
    retu '.'
  else
    retu dir
  endif
endf
let g:current_git_dir = GetGitDir()
nn <c-p> :Files <c-r>=g:current_git_dir<cr><cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map  t <Plug>(easymotion-bd-f)
hi link EasyMotionTarget Exception
hi link EasyMotionIncCursor Search

" Lightline
fu! LightlineFilepath()
  let path = ""
  let subs = reverse(split(expand('%:p'), "/"))
  let i = 0
  for s in subs
    if i == 0
      let path = s
      let i += 1
    elseif i < 4
      let prev_path = path
      let path = s . '/' . prev_path
      let i += 1
    else
      break
    endif
  endfor
  retu path
endf
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilepath'
      \ }
      \ }
let g:lightline.winwidth = 1000
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

" FAR
let g:far#source = 'rg'
au filetype far map <buffer> <c-f> :Fardo<cr>:q<cr>
let g:far#auto_write_replaced_buffers = 0

fu! FarPromptBuffer(rngmode, rngline1, rngline2, ...) abort range "{{{
  call far#tools#log('============ FAR PROMPT ================')

  let pattern = input('Search in buffer (pattern): ', '', 'customlist,far#FarSearchComplete')
  call far#tools#log('>pattern: '.pattern)
  if empty(pattern)
    call far#tools#echo_err('No pattern')
    retu
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
  retu join(paths, ' ')
endf

fu! FarPromptActiveBuffers(rngmode, rngline1, rngline2, ...) abort range "{{{
  call far#tools#log('============ FAR PROMPT ================')

  let pattern = input('Search in active buffers (pattern): ', '', 'customlist,far#FarSearchComplete')
  call far#tools#log('>pattern: '.pattern)
  if empty(pattern)
    call far#tools#echo_err('No pattern')
    retu
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

" ALE
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0
let g:ale_linters = {'python': ['flake8'],
                   \ 'cs': []}
let g:ale_python_flake8_options = '--max-line-length 100'
let g:ale_fixers = {'*': ['uncrustify', 'remove_trailing_lines', 'trim_whitespace'],
                  \ 'python': ['autopep8', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_python_autopep8_options = '--max-line-length 100'
nm <c-m-n> <Plug>(ale_next_wrap)
nm <c-m-p> <Plug>(ale_previous_wrap)
nm <c-m-f> <Plug>(ale_fix)

" Echodoc
let g:echodoc#enable_at_startup = 1

" YouCompleteMe
set completeopt-=preview

" Add support for machine specific dotfile
" Source at end so that default configurations can be overriden
so ~/.config/nvim/machine.vim
