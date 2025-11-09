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

  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed      = {
          'html',
          'css',
          'javascript',
          'liquid'
        },
        highlight             = { enable = true },
        indent                = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
      })
    end,
  })

  use({
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
    end

  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

      })
    end,
  })

  use({
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({})
    end
  })

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
end)
