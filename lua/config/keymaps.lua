local km = vim.keymap.set
local fzf = require('fzf-lua')
local obsidian = require('obsidian')

km('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Source File' })
km('n', '<leader>w', ':write<CR>', { desc = 'Write' })
km('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })

-- Language Formatting
km('n', '<leader>lf', require('conform').format, { desc = 'Conform: Format File' })
km('', "<leader>sf", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
      end
    end
  end)
end, { desc = "Conform: Format Selection" })

-- Test Config
km('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: Rename Variable' })
km('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })

-- Open Diagnostic Floting Window
km('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic window' })

-- fzf-lua
-- Files and Search
km('n', "<leader>ff", fzf.files, { desc = "FZF: Files" })
km('n', "<leader>fw", fzf.grep_cword, { desc = "FZF: Grep word under cursor" })
km('n', "<leader>fb", fzf.buffers, { desc = "FZF: Buffers" })
km('n', "<leader>fh", fzf.help_tags, { desc = "FZF: Help Tags" })
km('n', "<leader>fg", fzf.live_grep, { desc = "FZF: Grep" })
km('n', "<leader>fo", fzf.oldfiles, { desc = "Old Files" })
km('n', "<leader>fm", fzf.marks, { desc = "FZF: Marks" })

-- Git
km('n', "<leader>gs", fzf.git_status, { desc = "FZF: Git Status" })
km('n', "<leader>gb", fzf.git_branches, { desc = "FZF: Git Branches" })
km('n', "<leader>ga", fzf.git_blame, { desc = "FZF: Git Blame" })
km('n', "<leader>gc", fzf.git_commits, { desc = "FZF: Git Commits" })

-- Utilities
km('n', "<leader>fk", fzf.keymaps, { desc = "FZF: Keymaps" })
km('n', "<leader>ss", fzf.spell_suggest, { desc = "FZF: Spelling Suggestions" })
km('n', "<leader>sc", fzf.spellcheck, { desc = "FZF: Spelling Check" })

-- LSP References
km('n', '<leader>gr', fzf.lsp_references, { desc = 'FZF: LSP references' })
km('n', '<leader>gd', fzf.lsp_definitions, { desc = 'FZF: LSP definitions' })
km('n', '<leader>gi', fzf.lsp_implementations, { desc = 'FZF: LSP implementations' })
km('n', '<leader>gt', fzf.lsp_typedefs, { desc = 'FZF: LSP type defs' })

-- Buffer Navigation
km('n', '<leader>n', ':bn<cr>', { desc = 'Buffers: Next Buffer' })
km('n', '<leader>p', ':bp<cr>', { desc = 'Buffers: Previous Buffer' })
km('n', '<leader>x', ':bd<cr>', { desc = 'Buffers: Close Buffer' })

-- Toggle Comment
km({ 'n' }, '<leader>/', 'gbc', { remap = true, desc = 'Comment: Toggle Comment Block' })
km({ 'n' }, '<leader>;', 'gcc', { remap = true, desc = 'Comment: Toggle Comment Line' })
km({ 'v' }, '<leader>/', '<Esc>:normal gvgb<CR>', { desc = 'Comment: Toggle Comment Block' })
km({ 'v' }, '<leader>;', '<Esc>:normal gvgc<CR>', { desc = 'Comment: Toggle Comment Line' })

-- Markdown and Obsidian
km('', '<leader>mp', ':MarkdownPreviewToggle<CR>')
km("n", "<leader>gf", ':Obsidian follow_link<CR>')

-- Indentation
km('v', '<Tab>', '>gv', { desc = 'Indent' })
km('v', '<S-Tab>', '<gv', { desc = 'Outdent' })
