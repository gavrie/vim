" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"let g:session_autoload = 0
"let g:session_autosave = 0

" Put VIM swap files in one place
set directory=~/.vim/swap

let mapleader = ","
nmap <silent><Leader>/ :nohlsearch<CR>
nmap <silent><Leader>ve :e ~/.vimrc<CR>
nmap <silent><Leader>vs :so ~/.vimrc<CR>

" run py.test on current file sending output to quickfix window
noremap <Leader>p :update<CR>:cexpr system('py.test --tb=short '.expand('%:p'))<CR>:cwindow<CR>
" run py.test on current file sending output to quickfix window
"noremap <C-F5> :update<CR>:cexpr system(expand('%:p'))<CR>:copen<CR>

nmap <silent><Leader>gu :GundoToggle<CR>

set showmatch
syntax on
set hlsearch
set nowrap
set wrapmargin=0
set textwidth=0
" To wrap lines at word boundaries:
" set linebreak
" set wrap

" Plugins
let g:LustyExplorerSuppressRubyWarning = 1

" Settings from VIMRUNTIME/vimrc_example.vim
set nocompatible
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

colorscheme vividchalk

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running")

  " Disable blinking cursor
  set gcr=a:blinkon0

  " My settings
  set guifont=Monaco:h18
  " No scrollbar or toolbar
  set guioptions=aAce
  " Make window as large as possible
  set columns=300
  set lines=60
  
  set number
  "set numberwidth=6

  " Tagbar
  let g:tagbar_left = 1
  let g:tagbar_width = 40
  autocmd VimEnter * nested TagbarOpen

  " My customizations to vividchalk
  highlight Comment guifg=#E795E1
  highlight LineNr guifg=#555555 guibg=#000000

  highlight SpecialKey guifg=#808080

  " Highlight trailing spaces:
  "set list
  "set listchars=tab:>-,trail:.,extends:#,nbsp:.
  "highlight SpecialKey guifg=#FF0000
  "highlight SpecialKey guibg=#FF8080

  " Bring terminal to foreground after writing commit message (not used with fugitive!)
  "au BufDelete *.git/COMMIT_EDITMSG :silent !open -a Terminal
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=[%{getcwd()}]%-14.(\ %l,%c%V%)\ %P
  set rulerformat=
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

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

  set autoindent		" always set autoindenting on

endif " has("autocmd")

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

"" omnicomplete with tab
"function! SuperCleverTab()
"    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        if &omnifunc != ''
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            return "\<C-K>"
"        else
"            return "\<C-N>"
"        endif
"    endif
"endfunction
"
"inoremap <Tab> <C-R>=SuperCleverTab()<CR>
"
set tags+=~/.vim/tags/python.ctags

set softtabstop=4
set shiftwidth=4
set expandtab
set numberwidth=6

" save default session
"set sessionoptions+=resize,winpos
"autocmd VIMEnter * :source ~/.vim/sessions/default.vim
"autocmd VIMLeave * :mksession! ~/.vim/sessions/default.vim

" Disable arrows!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" tcomment
let g:tcommentMapLeader1 = ''

" Make `gf` work on import statements from python stdlib
" source: http://sontek.net/python-with-a-modular-ide-vim
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

