return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {},
      shopify_theme_ls = {},
      cssls = {},
      html = {},
      jsonls = {},
      emmet_ls = {},
      -- cssmodules_ls = {},
      eslint = {},
      tailwindcss = {},
      ts_ls = {},
      marksman = {}
    }
  },
  config = function(_, opts)
    local lspconfig = vim.lsp.config
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server] = config
    end
  end

}
