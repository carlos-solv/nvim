require('config.pack')
require('config.options')
require('config.keymaps')
require('config.lsp')
require('config.autocmds')

do
  local ok, hooks = pcall(require, "ibl.hooks")
  if ok then
    hooks.register(hooks.type.ACTIVE, function(bufnr)
      return not vim.b[bufnr].heavy_file_mode
    end)
  end
end

local function heavy_file_mode(enable)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].heavy_file_mode = enable

  if enable then
    pcall(vim.treesitter.stop, bufnr)

    pcall(vim.diagnostic.enable, false, { bufnr = bufnr })

    pcall(function()
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end)
    pcall(function()
      vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr })
    end)

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      pcall(vim.lsp.buf_detach_client, bufnr, client.id)
    end

    -- A few local editor features that often help on huge files
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.wrap = false

    vim.notify("Heavy file mode enabled for current buffer", vim.log.levels.INFO)
  else
    -- Re-enable the cheap/builtin things
    pcall(vim.diagnostic.enable, true, { bufnr = bufnr })


    vim.opt_local.foldmethod = "index" -- change if your normal default differs
    vim.opt_local.swapfile = true
    vim.opt_local.undofile = true
    vim.opt_local.wrap = false

    pcall(vim.treesitter.start, bufnr)

    vim.notify(
      "Heavy file mode disabled. Reopen buffer with :edit if your LSP does not auto-reattach.",
      vim.log.levels.WARN
    )
  end

  pcall(function()
    require("ibl").refresh(bufnr)
  end)
end

vim.api.nvim_create_user_command("HeavyFile", function(opts)
  local bufnr = vim.api.nvim_get_current_buf()

  local enable
  if opts.args == "on" then
    enable = true
  elseif opts.args == "off" then
    enable = false
  else
    enable = not vim.b[bufnr].heavy_file_mode
  end

  heavy_file_mode(enable)
end, {
  nargs = "?",
  complete = function()
    return { "on", "off" }
  end,
  desc = "Toggle lightweight mode for current buffer",
})
