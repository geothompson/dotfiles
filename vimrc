"            georges vimrc
   " auto-installs vim-plug if not found
   "Plug 'neoclide/coc.nvim', {'branch': 'release'}
   "plug 'gabrielelana/vim-markdown'



 if filereadable(expand("~/.vim/autoload/plug.vim"))
   call plug#begin('~/.vim/plugged')
   Plug 'https://gitlab.com/rwxrob/vim-pandoc-syntax-simple'
   Plug 'git@github.com:Valloric/YouCompleteMe.git'
   Plug 'git@github.com:airblade/vim-gitgutter.git'
   Plug 'dapplebeforedawn/vim-typing-practice'
   Plug 'dapplebeforedawn/vim-typing-practice'
   Plug 'git@github.com:kien/ctrlp.vim.git'
   Plug 'git@github.com:rking/ag.vim.git'
   Plug 'HenryNewcomer/vim-theme-papaya'
   Plug 'vim-airline/vim-airline-themes'
   Plug 'beloglazov/vim-textobj-quotes'
   Plug 'sainnhe/gruvbox-material'
   Plug 'ThePrimeagen/vim-be-good'
   Plug 'kana/vim-textobj-entire'
   Plug 'vim-airline/vim-airline'
   Plug 'kana/vim-textobj-indent'
   Plug 'preservim/nerdcommenter'
   Plug 'vim-pandoc/vim-pandoc'
   Plug 'junegunn/vim-peekaboo'
   Plug 'kana/vim-textobj-user'
   Plug 'kana/vim-textobj-line'
   Plug 'tpope/vim-vividchalk'
   Plug 'scrooloose/nerdtree'
   Plug 'tpope/vim-fugitive'
   Plug 'jpalardy/vim-slime'
   Plug 'godlygeek/tabular'
   Plug 'tpope/vim-endwise'
   Plug 'ap/vim-css-color'
   Plug 'morhetz/gruvbox'
	 Plug 'vimwiki/vimwiki'
   call plug#end()
endif

filetype off                  " required
filetype plugin on

" a plugin where to add man page in window(can't get it to work)
runtime! ftplugin/man.vim

runtime! macros/matchit.vim

" markdown macros
let @p= 'ysiw*ysf**lysf**'
let g:ycm_show_diagnostics_ui = 0

" with a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","


augroup pandoc_syntax
    au! bufnewfile,buffilepre,bufread *.md set filetype=markdown.pandoc
augroup END

" sets vims local working directoy to home
autocmd BufEnter * silent! lcd ~/


" make vim faster
set timeoutlen=1000
set ttimeoutlen=0

" start at last place you were editing
au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" common word mistake snippets
iabbrev rescources resources
iabbrev Rescources Resources

" rust format command
autocmd vimleavepre *.rs !rustfmt                              %

" if statement snippets

augroup filetype_js
  autocmd!
  autocmd filetype javascript :iabbrev <buffer> iff if (){<CR>}<up><right><right><right>
augroup END

augroup filetype_sh
  autocmd!
  autocmd filetype sh :iabbrev <buffer> iff if [[  ]]<esc>hhhi
augroup END

augroup filetype_python
  autocmd!
  autocmd filetype python :iabbrev <buffer> iff if:<left><up><right>
augroup END

" fixes everything being highlighted after scrolling"
augroup venter
  autocmd!
  autocmd vimenter * set t_ut=
augroup END

iabbrev #! #!/bin/bash

nnoremap <leader>c<leader> !!cal<cr>

" gitgutter mappings
nmap <leader>gh :diffget //3<cr>
nmap <leader>gu :diffget //2<cr>
nmap <leader>gs :g<cr>
let g:gitgutter_enabled = 0

" maps jk for easier escape
inoremap jk <esc>

" resources current file
nnoremap <leader>sr :so %<cr>

" Newlines
nnoremap <leader>k o<ESC>k
nnoremap <leader>j O<ESC>j

" fuck ex mode!
nnoremap Q <nop>

" move line up and down
noremap - ddp
noremap _ ddkP

"copy a line down
nnoremap <leader>d yyp

"move highlighted section up or down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"----------insert mode remaps------------------------

"quick movements
inoremap II <esc>i
inoremap AA <esc>a
inoremap OO <esc>O


"line modficatons

inoremap CC <esc>c
inoremap SS <esc>s
inoremap DD <esc>dd
inoremap UU <esc>u

inoremap <c-h> <esc>i

" make word uppercase
inoremap <c-u> <esc>viwui

" no arrow keys (vi muscle memory)
"noremap <up> :echoerr "umm, use k instead"<cr>
"noremap <down> :echoerr "umm, use j instead"<cr>
"noremap <left> :echoerr "umm, use h instead"<cr>
"noremap <right> :echoerr "umm, use l instead"<cr>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>


"onoremap ih :<c-u>execute '"normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>

" fast saving
nnoremap <leader>w :w!<cr>


"nerdtree
let nerdtreeminimalui = 1



filetype plugin on

au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sets how many lines of history vim has to remember
set nonu
set number relativenumber
set history=100
set formatoptions-=w
set formatoptions+=1
set formatoptions+=m
set formatoptions+=l   " long lines not broken in insert mode
set formatoptions-=b   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions-=v   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions+=j   " delete comment prefix when joining
set formatoptions-=a   " disable auto-formatting of paragraph changes
set formatoptions-=r   " don't auto-insert comment leader on enter in insert
set formatoptions-=o   " don't auto-insert comment leader on o/o in normal
set formatoptions+=c   " autowrap comments using textwidth with leader
set formatoptions-=t   " don't auto-wrap text using text width


"prevents truncated yanks, deletes, ect....
set viminfo='20,<1000,s100

" keep cursor in middle of screen
set scrolloff=999

"prevents truncated yanks, deletes, ect....
set viminfo='20,<1000,s100


" set to auto read when a file is changed from the outside
set autoread
au focusgained,bufenter * checktime





" :w sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set 7 lines to the cursor - when moving vertically using j/k
set so=7

" avoid garbled characters in chinese language windows os
let $lang='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" turn on the wild menu
set wildmenu

"searches recursively into subfolders
"provides tab-completion for all file-related tasks
set path+=**

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.ds_store
endif

"always show current position
set ruler

" height of the command bar
set cmdheight=1

set omnifunc=syntaxcomplete#Complete

set hid

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ignore case when searching
set ignorecase

" when searching try to be smart about cases
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regular expressions turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" properly disable sound on errors on macvim
if has("gui_macvim")
    autocmd guienter * set vb t_vb=
endif


" add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable syntax highlighting
syntax enable
syntax on

" enable 256 colors palette in gnome terminal
if $colorterm == 'gnome-terminal'
    set t_co=256
endif

" airline theme
let g:airline_theme='jellybeans'

try

catch
endtry

colorscheme mybeans

set background=dark


" set extra options when running in gui mode
if has("gui_running")
    set guioptions-=t
    set guioptions-=e
    set t_co=256
    "set guitablabel=%m\ %t
endif

" set utf8 as standard encoding and en_us as the standard language
set encoding=utf8

" use unix as the standard file type
set ffs=unix,dos,mac

" => files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn backup off, since most stuff is in svn, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use spaces instead of tabs
set expandtab

" be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" linebreak on 500 characters
set lbr
set tw=500

set ai "auto indent
set si "smart indent
set wrap "wrap lines
set textwidth=73
set noswapfile
"set nohlsearch


""""""""""""""""""""""""""""""
" => visual mode related
""""""""""""""""""""""""""""""
" visual mode pressing * or # searches for the current selection
" super useful! from an idea by michael naumann
vnoremap <silent> * :<c-u>call visualselection('', '')<cr>/<c-r>=@/<cr><cr>
vnoremap <silent> # :<c-u>call visualselection('', '')<cr>?<c-r>=@/<cr><cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "=> moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable highlight when <leader><cr> is pressed(<cr> == enter)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" close the current buffer
map <leader>bd :bclose<cr>:tabclose<cr>gt

" close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<cr>
au tableave * let g:lasttab = tabpagenr()


" opens a new tab with the current buffer's path
" super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch cwd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" return to last edit position when opening files (you want this!)
au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => status line
""""""""""""""""""""""""""""""
" always show the status line
set laststatus=2

" format the status line
set statusline=\ %{HasPaste()}%f%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ \ line:\ %l\ \ column:\ %c

" delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd bufwritepre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove the windows ^m - when the encodings gets messed up
noremap <leader>m mmhmt:%s/<c-v><cr>//ge<cr>'tzt'm

" quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" quickly open a markdown buffer for scribble
"map <leader>x :e ~/buffer.md<cr>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" turns of highlighting(not working with <cr> after it, should figure out why)
map <leader><cr> :noh<cr>


function! s:font()
  if has('mac')
    return 'Monaco:h12'
  elseif has('win32')
    return 'Consolas:h11,Courier New:h10'
  else
    return 'Monospace Medium 12'
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'paste mode  '
    endif
    return ''
endfunction

" don't close window, when deleting a buffer
command! Bclose call <sid>BufcloseCloseIt()
function! <sid>BufcloseCloseit()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
iabbrev printl println!("");<left><left><left><c-r>=Eatchar('\s')<cr>
iabbrev { {<cr>}OO

let b:surround_{char2nr('e')} = "\r\n}"
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1

" fixes bug where tabline appears while only having one open
set showtabline=1
set nospell
