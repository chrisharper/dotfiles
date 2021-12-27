local indent, width = 2, 80
vim.opt.colorcolumn = tostring(width)  -- Line 80 ruler
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
vim.opt.cursorline = true               -- Highlight cursor line
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.hidden = true                   -- Enable background buffers
vim.opt.ignorecase = true               -- Ignore case
vim.opt.joinspaces = false              -- No double spaces with join
vim.opt.list = true                     -- Show some invisible characters
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Relative line numbers
vim.opt.scrolloff = 4                   -- Lines of context
vim.opt.shell= 'bash --login'
vim.opt.shiftround = true               -- Round indent
vim.opt.shiftwidth = indent             -- Size of an indent
vim.opt.sidescrolloff = 8               -- Columns of context
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = indent                 -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.textwidth = width               -- Maximum width of text
vim.opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
vim.opt.wrap = false                    -- Disable line wrap

vim.cmd 'colorscheme gruvbox'
vim.g.mapleader = ' '

