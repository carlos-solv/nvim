-- vim.filetype.add({ extension = { liquid = 'liquid' } })
vim.lsp.config['shopify_theme_ls'] = {
  cmd = { 'shopify', 'theme', 'language-server' },
  filetypes = { 'liquid' },
  -- root_markers = {
  --   '.shopifyignore',
  --   '.theme-check.yml',
  --   '.theme-check.yml',
  --   'shopify.theme.toml',
  --   'shopify.extension.toml'
  -- },
  -- root_dir = require('lspconfig').util.root_pattern({
  --   '.shopifyignore',
  --   '.theme-check.yml',
  --   '.theme-check.yml',
  --   'shopify.theme.toml',
  --   'shopify.extension.toml'
  -- }),
  init_options = {
    enableSchema = true,
    enableCompletions = true,
    enableSnippets = true,
    enableValidations = true
  },
  flags = { debounce_text_changes = 150 }

}

vim.lsp.enable({
  'lua_ls',
  'shopify_theme_ls',
  'cssls',
  'html',
  'jsonls',
  'emmet_ls',
  -- 'cssmodules_ls',
  'eslint',
  'tailwindcss',
  'ts_ls',
  'marksman'
})
