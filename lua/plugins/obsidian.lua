local home = vim.fn.expand("~")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,

  -- Only load when opening/creating markdown files
  -- inside ~/Documents/vault or ~/Documents/zettelkasten
  event = {
    "BufReadPre " .. home .. "/Documents/vault/**.md",
    "BufNewFile " .. home .. "/Documents/vault/**.md",
    "BufReadPre " .. home .. "/Documents/zettelkasten/**.md",
    "BufNewFile " .. home .. "/Documents/zettelkasten/**.md",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "zettelkasten",
          path = home .. "/Documents/zettelkasten",
        },
        {
          name = "vault",
          path = home .. "/Documents/vault",
        },
      },
    })
  end,
}
