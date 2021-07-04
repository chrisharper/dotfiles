local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to seDTreeToggle
local api  = vim.api

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

require "paq" {
  "savq/paq-nvim";                                  -- plugin manager
  "morhetz/gruvbox";                                -- colourscheme 
  "preservim/nerdtree";                             -- file explorer
  "junegunn/fzf";                                   -- fuzzy file fider
  "junegunn/fzf.vim";                               
  "itchyny/lightline.vim";                          -- bottom status bar
  "mhinz/vim-signify";                              -- git side +/- symbol
  "lilydjwg/colorizer";                             -- hexcode to colours
  "tpope/vim-fugitive";                             -- git helper functions
  "junegunn/gv.vim";                                -- git commit browser
  "christoomey/vim-tmux-navigator";                 -- vim/tmux integration
  "easymotion/vim-easymotion";                      -- quicker vim motions
  "nvim-treesitter/nvim-treesitter";                -- syntax
}
local indent, width = 2, 80
opt.colorcolumn = tostring(width)  -- Line 80 ruler
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.cursorline = true               -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.textwidth = width               -- Maximum width of text
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap


cmd 'colorscheme gruvbox'

g.mapleader = ' '
g.lightline = {
       ['colorscheme'] = 'gruvbox' ,
       ['active'] = {
         ['left'] = { { 'mode', 'paste' } ,{ 'gitbranch', 'readonly', 'filename', 'modified' } }
       },
       ['component_function'] = {
         ['gitbranch'] = 'FugitiveHead'
       },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
}

-- vim-easymotion
g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1

-- colorizer
g.colorizer_nomap = 1 

-- vim-signify
g.signify_sign_add               = '+'
g.signify_sign_delete            = '_'
g.signify_sign_delete_first_line = '‾'
g.signify_sign_change            = '~'
g.signify_sign_show_count = 0
g.ignify_sign_show_text = 1

-- Start NERDTree when Vim starts with a directory argument.
cmd  "autocmd StdinReadPre * let s:std_in=1 "
cmd  "autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0])  \z
     && !exists('s:std_in') |execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif"

-- Exit Vim if NERDTree is the only window left.
cmd  "autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |     quit | endif "




map('n','<leader>f',':Files<CR>')
map('n','<leader>n',':NERDTreeToggle<CR>')
map('n','<leader>gv',':GV<CR>')
map('n','<leader>t',':tabnew<CR>')
map('n','<leader>tn',':tabnext<CR>')
map('n','<leader>tm',':tabmove<CR>')
map('n','<leader>tc',':tabclose<CR>')
map('n','<leader>to',':tabonly<CR>')

-- Use alt + hjkl to resize windows
map('n','<M-j>',':resize -2<CR>')
map('n','<M-k>',':resize +2<CR>')
map('n','<M-l>',':vertical resize -2<CR>')
map('n','<M-h>',':vertical resize +2<CR>')


