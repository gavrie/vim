let mapleader = ","
nmap <silent> ,/ :nohlsearch<CR>
syntax on
set hlsearch

" Plugins
let g:LustyExplorerSuppressRubyWarning = 1
" taglist plugin
"let Tlist_Auto_Open = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File=1

" pathogen
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

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
  set guifont=Monaco:h16
  set guioptions-=T
  
  set number
  set numberwidth=6
  highlight LineNr guifg=#555555

  highlight Comment guifg=#E795E1
  highlight SpecialKey guifg=#808080

  " Highlight trailing spaces:
  "set list
  "set listchars=tab:>-,trail:.,extends:#,nbsp:.
  "highlight SpecialKey guifg=#FF0000
  "highlight SpecialKey guibg=#FF8080

  au BufDelete *.git/COMMIT_EDITMSG :silent !open -a Terminal
endif

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

" omnicomplete with tab
function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<CR>
set tags+=~/source/tags.python

set softtabstop=4
set shiftwidth=4
set expandtab

" save default session
"set sessionoptions+=resize,winpos
"autocmd VIMEnter * :source ~/.vim/sessions/default.vim
"autocmd VIMLeave * :mksession! ~/.vim/sessions/default.vim

" Configure Windows for 'IDE' state
function! IDE()
    "new
    only
    NERDTree
    Tlist
    " Move NERDTree window to top
    execute "normal \<C-W>K"
    " Go to Tlist window and move to bottom
    execute "normal \<C-W>j\<C-W>J"
    " Go to main window and move to right
    execute "normal \<C-W>k\<C-W>L"
    " Go to Tlist window and make it narrower
    execute "normal \<C-W>h30\<C-W><"
    " Return to main window
    execute "normal \<C-W>l"

    " chdir ~/source/qa/tlib
    " :cs add cscope.out
endfunction
command! IDE :call IDE()
