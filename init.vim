
let mapleader = ","

call plug#begin(stdpath('config').'/plugged')

Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()


set timeout timeoutlen=3000 ttimeoutlen=100

" remaps jk for an easier esc
inoremap jk <esc>

" resources current file
nnoremap <leader>sr :so %<cr>

" quick save
nnoremap <leader>w  :w! %<cr>

" copies a line down
nnoremap <leader>d yyp

"move highlighted section up or down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv


"----------insert mode remaps------------------------

"quick movements
inoremap II <esc>I
inoremap AA <esc>A
inoremap OO <esc>O
 
"line modficatons
inoremap CC <esc>c
inoremap SS <esc>s
inoremap DD <esc>dd
inoremap UU <esc>u

"moves cursor back one space in insert mode
inoremap <c-h> <esc>i

" make word uppercase
inoremap <c-U> <esc>viwui


"prevents truncated yanks, deletes, ect....
set viminfo='20,<1000,s100

" keep cursor in middle of screen
set scrolloff=999

"prevents truncated yanks, deletes, ect....
set viminfo='20,<1000,s100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


" keep cursor in middle of screen
set scrolloff=999

"prevents truncated yanks, deletes, ect....
set viminfo='20,<1000,s100


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set 7 lines to the cursor - when moving vertically using j/k
set so=7


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

" add a bit extra margin to the left
set foldcolumn=1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

try
	colorscheme gruvbox
catch
endtry


" enable syntax highlighting
syntax enable
syntax on


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


""""""""""""""""""""""""""""""
" => status line
""""""""""""""""""""""""""""""
" always show the status line
set laststatus=2

" format the status line
set statusline=\%f%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ \ line:\ %l\ \ column:\ %c

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



