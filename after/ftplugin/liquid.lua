-- Liquid only has block comments
vim.bo.commentstring = "{% comment %} %s {% endcomment %}"

-- Ensure a TS parser is attached (the real fix for the InspectTree quirk)
vim.schedule(function()
  -- Neovim ≥ 0.9
  pcall(vim.treesitter.start, 0, "liquid")
  -- Belt & suspenders: enable TS highlight if it's off
  pcall(vim.cmd, "silent! TSBufEnable highlight")
end)

-- Optional: prove this ftplugin ran
vim.schedule(function()
  vim.notify("[ftplugin/liquid] TS attached + commentstring set for " .. vim.fn.expand("%:t"))
end)
