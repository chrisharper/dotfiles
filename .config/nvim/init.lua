-- ln -s ~/.rustup/toolchains/nightly//bin/rust-analyzer
-- ~/.cargo/bin/rust-analyzer
local indent, width = 2, 80
vim.opt.colorcolumn = tostring(width)                   -- Line 80 ruler
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Completion options
vim.opt.cursorline = true                               -- Highlight cursor line
vim.opt.expandtab = true                                -- Use spaces instead of tabs
vim.opt.hidden = true                                   -- Enable background buffers
vim.opt.ignorecase = true                               -- Ignore case
vim.opt.joinspaces = false                              -- No double spaces with join
vim.opt.list = true                                     -- Show some invisible characters
vim.opt.number = true                                   -- Show line numbers
vim.opt.relativenumber = true                           -- Relative line numbers
vim.opt.scrolloff = 4                                   -- Lines of context
vim.opt.shell = 'bash --login'
vim.opt.shiftround = true                               -- Round indent
vim.opt.shiftwidth = indent                             -- Size of an indent
vim.opt.sidescrolloff = 8                               -- Columns of context
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true                                -- Do not ignore case with capitals
vim.opt.smartindent = true                              -- Insert indents automatically
vim.opt.splitbelow = true                               -- Put new windows below current
vim.opt.splitright = true                               -- Put new windows right of current
vim.opt.tabstop = indent                                -- Number of spaces tabs count for
vim.opt.termguicolors = true                            -- True color support
vim.opt.textwidth = width                               -- Maximum width of text
vim.opt.wildmode = { 'list', 'longest' }                -- Command-line completion mode
vim.opt.wrap = false                                    -- Disable line wrap

vim.g.mapleader = ' '


local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd.packadd('packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function()
  local use = require('packer').use
  -- plugin manager
  use "wbthomason/packer.nvim";

  --colorscheme
  use {
    "gruvbox-community/gruvbox",
    config = function()
      vim.cmd 'colorscheme gruvbox'
    end
  }

  -- syntax
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup({ ensure_installed = 'all' })
    end
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim' },
    config = function()
      require('telescope').setup {
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

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        name = 'recommended',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })
      lsp.setup()
      vim.diagnostic.config({
        virtual_text = true
      })
    end
  }

  -- git gutter line
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- 80 char line mark
  use 'lukas-reineke/indent-blankline.nvim'

  -- file browser
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup()
    end
  }
  -- tmux <-> navigation
  use 'christoomey/vim-tmux-navigator'

  -- packer packer_bootstrap
  if packer_bootstrap then
    require('packer').sync()
  end
end)



-- telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<Cmd>lua require('telescope.builtin').find_files() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<Cmd>lua require('telescope.builtin').live_grep() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<Cmd>lua require('telescope.builtin').buffers() <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fG", "<Cmd>lua require('telescope.builtin').git_commits() <CR>", { noremap = true })

-- nvim-tree
vim.api.nvim_set_keymap("n", "<leader>t", ':NvimTreeToggle <CR>', { noremap = true })
