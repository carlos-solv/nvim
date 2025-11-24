return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed      = { "liquid", "html", "javascript", "css", "lua", "markdown", "markdown_inline", "query", "svelte", "tsx", "typescript", "vim", "vimdoc", "vue", "xml", "go" },
      highlight             = { enable = true },
      --[[ context_commentstring = { enable = true, enable_autocmd = false }, ]]
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
}
