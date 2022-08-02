--auto install package manager if not present
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command.execute('packadd packer.nvim')
end

require ('packer').startup(function()

  -- plugin manager
  use "wbthomason/packer.nvim";

  --colorscheme
  use "gruvbox-community/gruvbox";

  -- syntax
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({ensure_installed='all'})
    end
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim','nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim'},
    config = function()
      require('telescope').setup {
        defaults = {
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
          grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
          file_sorter = require('telescope.sorters').get_fzy_sorter,
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          }
        }
      }
      require('telescope').load_extension('fzy_native')
    end
  }

  -- git gutter line
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

end)


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


-- telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<Cmd>lua require('telescope.builtin').find_files() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<Cmd>lua require('telescope.builtin').live_grep() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<Cmd>lua require('telescope.builtin').buffers() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fG", "<Cmd>lua require('telescope.builtin').git_commits() <CR>", { noremap = true })
