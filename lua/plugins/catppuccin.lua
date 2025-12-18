return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true
    },
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorschem("catppuccin")

      require("catppuccin").setup({
        flavour = 'mocha',
        transparent_background = 'true',
        integrations = {
          fzf = true,
          blink_cmp = {
            style = 'bordered'
          },
          nvimtree = true
        }
      })
    end
  }
}
