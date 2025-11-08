vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- packer
  use 'neovim/nvim-lspconfig'  -- nvim lspconfig
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        background = {
          light = 'latte',
          dark = 'mocha'
        },
      })
      vim.cmd("colorscheme catppuccin")
    end
  } -- colorscheme

  use {
    'ibhagwan/fzf-lua',
    requires = {
      { 'nvim-tree/nvim-web-devicons' }
    }
  } -- fzf-lua instead of telescope

  use {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({})
    end,
    tag = "*", requires = 'nvim-tree/nvim-web-devicons'
  }

  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end
  }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
end)
