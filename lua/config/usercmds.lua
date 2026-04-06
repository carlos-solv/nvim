vim.api.nvim_create_user_command("LspHere", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached")
    return
  end
  print(table.concat(vim.tbl_map(function(c) return c.name end, clients), ", "))
end, {})

vim.api.nvim_create_user_command("OtterClients", function()
  local ok, keeper = pcall(require, "otter.keeper")
  if not ok then
    print("otter.keeper not available")
    return
  end

  local main = vim.api.nvim_get_current_buf()
  local raft = keeper.rafts and keeper.rafts[main]

  if not raft then
    print("No otter raft for current buffer")
    return
  end

  local out = {}

  for _, lang in ipairs(raft.languages or {}) do
    local bufnr = raft.buffers and raft.buffers[lang]
    local names = {}

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        names[#names + 1] = string.format("%s[%d]", client.name, client.id)
      end
    end

    out[#out + 1] = {
      lang = lang,
      bufnr = bufnr,
      clients = (#names > 0) and names or { "none" },
    }
  end

  vim.print(out)
end, {})
