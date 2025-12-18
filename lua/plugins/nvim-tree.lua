return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      -- recommended by nvim-tree: disable netrw (do this before setup)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.opt.termguicolors = true

      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },
}
