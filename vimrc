set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'fatih/vim-go'
Plugin 'vim-scripts/bufkill.vim.git'
Plugin 'vim-scripts/camelcasemotion.git'
Plugin 'sjl/gundo.vim.git'
" Plugin 'sjbach/lusty.git'
Plugin 'scrooloose/nerdcommenter.git'
"Plugin 'kevinw/pyflakes-vim.git'
Plugin 'ervandew/supertab.git'
" Plugin 'godlygeek/tabular.git'
Plugin 'majutsushi/tagbar'
Plugin 'Lokaltog/vim-easymotion'

Plugin 'michaeljsmith/vim-indent-object.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-speeddating.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-abolish.git'
Plugin 'tpope/vim-unimpaired'

" Consider replacing with fzf:
Plugin 'kien/ctrlp.vim'

Plugin 'cespare/vim-toml'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'sukima/xmledit'
Plugin 'gavrie/vim-vividchalk.git'

call vundle#end()
""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:session_autoload = 0
"let g:session_autosave = 0

" Put VIM swap files in one place
" set directory=~/.vim/swap
" Don't create swap files:
set updatecount=0

let mapleader = ","
nmap <silent><Leader>/ :nohlsearch<CR>
nmap <silent><Leader>ve :e ~/.vimrc<CR>
nmap <silent><Leader>vs :so ~/.vimrc<CR>

" Go to directory of current file (useful for Go build)
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" run py.test on current file sending output to quickfix window
noremap <Leader>p :update<CR>:cexpr system('py.test --tb=short '.expand('%:p'))<CR>:cwindow<CR>
" run py.test on current file sending output to quickfix window
"noremap <C-F5> :update<CR>:cexpr system(expand('%:p'))<CR>:copen<CR>

nmap <silent><Leader>gu :GundoToggle<CR>

set showmatch
syntax on
set hlsearch
set wrap
set wrapmargin=0
set textwidth=0
" To wrap lines at word boundaries:
" set linebreak
" set wrap

" Plugins
let g:LustyExplorerSuppressRubyWarning = 1

" Settings from VIMRUNTIME/vimrc_example.vim
set backspace=indent,eol,start

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

colorscheme vividchalk

set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" if has("autocmd")
if has("gui_running")

  " autocmd! GUIEnter * set vb t_vb=
  set visualbell t_vb=

  " Disable blinking cursor
  set gcr=a:blinkon0

  " My settings
  set guifont=Monaco:h14
  " No scrollbar or toolbar
  set guioptions=aAce
  " Make window as large as possible
  set columns=300
  set lines=60

  "set number
  "set numberwidth=6

  " Tagbar
  let g:tagbar_left = 1
  let g:tagbar_width = 40

  let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

  autocmd VimEnter * nested TagbarOpen
  nmap <F2> :wincmd o<CR>:TagbarOpen<CR>

  " My customizations to vividchalk
  highlight Comment guifg=#E795E1
  highlight LineNr guifg=#555555 guibg=#000000

  highlight SpecialKey guifg=#808080

  " Highlight trailing spaces:   
  " Highlight tabs:	
  set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:.

  " Those were disabled for golang -- consider making these filetype specific:
  "set list
  "highlight SpecialKey guifg=#FFFFFF
  "highlight SpecialKey guibg=#BB0000

  " set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=[%{getcwd()}]%-14.(\ %l,%c%V%)\ %P
  " set rulerformat=

  autocmd QuickFixCmdPost *grep* cwindow

  set fullscreen
endif

" Always show status line
"set laststatus=2

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " YAML
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd VimResized set columns=300

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" Hacks
nmap <F3> :set columns=300<CR>
nmap <Leader>p :set ft=python<CR>
"set foldmethod=indent
"set foldignore=

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

set hidden

set wildignore+=*.o,*.obj,.git,*.pyc

" Allow saving a file with sudo
" FIXME: causes "sticky w"
"cmap w!! %!sudo tee > /dev/null %

" cscope
if has("cscope")
    set csto=0
    set cscopetag   " search cscope for tags
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
endif

set tags+=~/.vim/tags/python.ctags

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set numberwidth=6

" save default session
"set sessionoptions+=resize,winpos
"autocmd VIMEnter * :source ~/.vim/sessions/default.vim
"autocmd VIMLeave * :mksession! ~/.vim/sessions/default.vim

" Disable arrows!
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" jj maps to escape
inoremap jj <Esc>

"" Relative line numbers
" function! NumberToggle()
"   if(&relativenumber == 1)
"     set number
"   else
"     set relativenumber
"   endif
" endfunc

" nnoremap <C-n> :call NumberToggle()<cr>
" :au FocusLost * :set number
" :au FocusGained * :set relativenumber
" :au BufEnter * :set relativenumber

" Underscore is not part of word
"set iskeyword-=_

" NERDComment
let NERDSpaceDelims = 1

"" Make `gf` work on import statements from python stdlib
"" source: http://sontek.net/python-with-a-modular-ide-vim
"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

"set path+=/Users/gavriep/source/go/src

set clipboard=unnamed

" Hebrew support
":set keymap=hebrew_utf-8
":set invrighleft

" jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0

" supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" markdown
au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown setlocal lbr
au FileType markdown setlocal wrap

au BufRead,BufNewFile *.t set filetype=sh

au BufRead,BufNewFile *Vagrantfile* set filetype=ruby

" toml
" au BufRead,BufNewFile *.toml set filetype=dosini

" vim-go
let g:go_fmt_command = "goimports"
let g:go_oracle_scope = "github.com/elastifile/tesla"
" let g:go_autodetect_gopath = 0

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-referrers)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test-compile)
" au FileType go nmap <leader>t :call go#cmd#Test('-c')<CR>
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>e <Plug>(go-rename)
