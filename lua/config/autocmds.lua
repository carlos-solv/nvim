vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true,

      })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('my.indent', { clear = true }),
  pattern = { '*.md', '*.js', '*.html', '*.css', '*.liquid', '*.lua', '*.json', '*.ts', '*.tsx', '*.jsx' },
  callback = function(ev)
    vim.bo[ev.buf].tabstop = 2
    vim.bo[ev.buf].softtabstop = 2
    vim.bo[ev.buf].shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('my.lastloc', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.fn.line([['"]]) > 0 and vim.fn.line([['"]]) <= vim.fn.line('$') then
      vim.cmd([[normal! g`"]])
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufReadPost' }, {
  group = vim.api.nvim_create_augroup('my.folds', { clear = true }),
  callback = function()
    if vim.bo.buftype == '' then
      vim.opt_local.foldmethod = 'indent'
    end
  end,
})

-- nvim-tree integration
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function(ev)
    vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", {
      buffer = ev.buf,
      desc = "Claude: Add File From Tree",
    })
  end,
})

