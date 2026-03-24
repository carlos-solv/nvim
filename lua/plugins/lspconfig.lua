return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },
  opts = {
    servers = {
      lua_ls = {},
      shopify_theme_ls = {},
      cssls = {},
      html = {},
      jsonls = {},
      emmet_ls = {},
      prisma_language_server = {},
      gopls = {},
      eslint = {},
      tailwindcss = {},
      ts_ls = {},
    },
  },
  config = function(_, opts)
    local lspconfig = vim.lsp.config

    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server] = config
    end
  end,
}
