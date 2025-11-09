require("config.globals")
require("config.options")
require("config.plugins")
require("config.keymaps")
require("config.lsp")
require("config.autocmd")

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

vim.cmd[[colorscheme catppuccin]]

