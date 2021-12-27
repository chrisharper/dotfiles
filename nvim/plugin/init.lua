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
    run = ":TSUpdate"
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim','nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim'},
  }

  -- lsp 
  use { 
    "neovim/nvim-lspconfig" ,
  }

  -- completion
  use {
    'hrsh7th/nvim-cmp',

    requires = {'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp','hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
                'L3MON4D3/LuaSnip','saadparwaiz1/cmp_luasnip'
              },
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



