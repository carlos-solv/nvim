-- vim.filetype.add({ extension = { liquid = 'liquid' } })
vim.lsp.config['shopify_theme_ls'] = {
  cmd = { 'shopify', 'theme', 'language-server' },
  filetypes = { 'liquid' },
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
  'basedpyright',
  'eslint',
  'tailwindcss',
  'ts_ls',
})
