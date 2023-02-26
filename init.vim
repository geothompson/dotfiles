" inspored by nvim kickstart and wrxrob

call plug#begin(stdpath('config').'/plugged')

Plug 'sirver/ultisnips'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'preservim/nerdcommenter'
Plug 'wellle/targets.vim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}
Plug 'lervag/vimtex'
Plug 'lewis6991/gitsigns.nvim'
Plug 'folke/which-key.nvim'


" for telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" for lsp
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'folke/neodev.nvim'
Plug 'j-hui/fidget.nvim'

"autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luaSnip'

" Git Realated
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'


" Gui
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" for tabstop and shiftwidth detection?
Plug 'tpope/vim-sleuth'
Plug 'lukas-reineke/indent-blankline.nvim'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'navarasu/onedark.nvim'

call plug#end()

"embedded lua config stuff
lua << EOF

vim.o.mouse = 'a'
vim.wo.signcolumn= 'yes'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


require("mason").setup()
require("mason-lspconfig").setup()
require("fidget").setup({})
require("which-key").setup({})

-- treesitter setup
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { disable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>cn', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  pyright = {},
  ocamllsp = {},
  grammarly = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

EOF


let mapleader = ","

let clipboard = 'unmamedplus'




let g:cpp_simple_highlight = 1

let g:tex_flavor= 'latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


" for UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

set timeout timeoutlen=3000 ttimeoutlen=100

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

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


" for merlin(OCaml)
:set rtp+=<SHARE_DIR>/merlin/vim

:set t_BE=

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
      colorscheme onedark
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

"set statusline=\%f%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ \ line:\ %l\ \ column:\ %c

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'



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



nnoremap <buffer> <leader>b :call PythonRunInScratch()<cr>
function! PythonRunInScratch()

  "run the current python file
  let output = system("python3" . " " . bufname("%"))

  " Open a new split and name it
  vsplit __Python_Output__

  " clear the buffer
  normal! ggdG
  setlocal filetype=python
  setlocal buftype=nofile

  "Insert output
  call append(0, split(output, '\v\n'))

endfunction





