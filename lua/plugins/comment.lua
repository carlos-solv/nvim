local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
      and require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
end

return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = function()
    local U                = require("Comment.utils")
    local ok_int, internal = pcall(require, "ts_context_commentstring.internal")
    local ok_utl, utils    = pcall(require, "ts_context_commentstring.utils")

    return {
      pre_hook = function(ctx)
        -- Only special-case .liquid buffers
        if vim.bo.filetype ~= "liquid" or not (ok_int and ok_utl) then
          -- fall back to normal ts-context behavior if available
          if ok_int then
            local key = (ctx.ctype == U.ctype.line) and "__default" or "__multiline"
            return internal.calculate_commentstring({ key = key })
          end
          return
        end

        -- Ask ts-context-commentstring what it would use at this location
        local location
        if ctx.ctype == U.ctype.block then
          location = utils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = utils.get_visual_start_location()
        end

        local key = (ctx.ctype == U.ctype.line) and "__default" or "__multiline"
        local ts_cs = internal.calculate_commentstring({ key = key, location = location })

        -- Our policy for .liquid files:
        -- - If context is HTML (<!-- %s -->) or pure Liquid (nil), use Liquid block comments
        -- - If context is JS or CSS, keep their native comments
        if (not ts_cs) or (ts_cs:match("^<!%-%-")) then
          return "{% comment %} %s {% endcomment %}"
        else
          return ts_cs   -- e.g., // %s or /* %s */ from JS/CSS
        end
      end,
    }
  end,
  --[[ config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end, ]]
}
