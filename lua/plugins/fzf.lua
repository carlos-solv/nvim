return {
  'ibhagwan/fzf-lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }
  },
  opts = {},
  config = function()
    require('fzf-lua').setup({
      file_ignore_patterns = { "%.git/", "%.obsidian/" },
    })
  end
}
