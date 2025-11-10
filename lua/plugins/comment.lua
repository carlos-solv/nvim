return {
  'numToStr/Comment.nvim',
  event = "VeryLazy",
  opts = function()
    local ok, integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    return {
      pre_hook = ok and integration.create_pre_hook()
    }
  end,
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring'
  }
}
