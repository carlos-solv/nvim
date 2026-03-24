return {
  "jmbuhr/otter.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("otter").setup({
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      lsp = {
        diagnostic_update_events = { "BufWritePost", "TextChanged", "InsertLeave" },
        root_dir = function(_, bufnr)
          return vim.fs.root(bufnr or 0, {
            ".git",
            "package.json",
            "shopify.theme.toml",
            ".shopifyignore",
          }) or vim.fn.getcwd()
        end,
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "liquid",
      callback = function()
        -- activates LSP for injected regions found by treesitter
        require("otter").activate({ "html", "css", "javascript", "typescript" }, true, true)
      end,
    })
  end,
}
