call plug#begin()
Plug 'morhetz/gruvbox'                                " colourscheme 
Plug 'preservim/nerdtree'                             " file explorer
Plug 'junegunn/fzf'                                   " fuzzy file fider
Plug 'junegunn/fzf.vim'                               
Plug 'itchyny/lightline.vim'                          " bottom status bar
Plug 'mhinz/vim-signify'                              " git side +/- symbol
Plug 'lilydjwg/colorizer'                             " hexcode to colours
Plug 'tpope/vim-fugitive'                             " git helper functions
Plug 'junegunn/gv.vim'                                " git commit browser
Plug 'christoomey/vim-tmux-navigator'                 " vim/tmux integration
Plug 'easymotion/vim-easymotion'                      " quicker vim motions
call plug#end()

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set noswapfile
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set list lcs=space:·,tab:->             " Set spaces to dots and tabs to arrows
set list!                               " Dont show by default 
set cc=80                               " Line 80 ruler

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
let g:mapleader= "\<Space>"

colorscheme gruvbox
let g:lightline = {
      \ 'colorscheme': 'gruvbox' ,
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

" colorizer
let g:colorizer_nomap = 1 "disable bindings

" vim-signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" Indent tab as 4 spaces in python
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

map <Leader>f :Files<CR>
map <Leader>w :set list!<CR>
map <Leader>n :NERDTreeToggle<CR>
map <leader>s :<Plug>(easymotion-overwin-f2)<CR>
map <leader>gv :GV<CR>
map <leader>t :tabnew<CR>
map <leader>tn :tabnext<CR>
map <leader>tm :tabmove<CR>
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-l>    :vertical resize -2<CR>
nnoremap <M-h>    :vertical resize +2<CR>


