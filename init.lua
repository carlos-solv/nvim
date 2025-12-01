-- Polyfill for math.tointeger on LuaJIT / older Lua
--[[ if math.tointeger == nil then
  function math.tointeger(x)
    local n = tonumber(x)
    if n == nil then
      return nil
    end
    -- Only treat integer-like numbers as integers
    if n == math.floor(n) then
      return n
    end
    return nil
  end
end ]]

require("config.lazy")
require("config.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmds")


--vim.cmd[[colorscheme catppuccin]]
