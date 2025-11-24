return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- tell it to NOT hook into nvim-treesitter's deprecated module
    vim.g.skip_ts_context_commentstring_module = true

    require("ts_context_commentstring").setup({
      enable = true,
      enable_autocmd = false
    })
  end,
}
