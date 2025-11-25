local km = vim.keymap.set
local fzf = require('fzf-lua')

km('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Source File' })
km('n', '<leader>w', ':write<CR>', { desc = 'Write' })
km('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })

-- Language Formatting
km('n', '<leader>lf', require('conform').format, { desc = 'Format File (with Conform)' })

-- Test Config
km('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Variable' })
km('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

-- Open Diagnostic Floting Window
km('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic window' })

-- fzf-lua
-- Files and Search
km("n", "<leader>ff", fzf.files, { desc = "FZF: Files" })
km("n", "<leader>fw", fzf.grep_cword, { desc = "FZF: Grep word under cursor" })
km("n", "<leader>fb", fzf.buffers, { desc = "FZF: Buffers" })
km("n", "<leader>fh", fzf.help_tags, { desc = "FZF: Help Tags" })
km("n", "<leader>fg", fzf.live_grep, { desc = "FZF: Grep" })
km("n", "<leader>fo", fzf.oldfiles, { desc = "Old Files" })
km("n", "<leader>m", fzf.marks, { desc = "Marks" })

-- Git
km("n", "<leader>gs", fzf.git_status, { desc = "FZF: Git Status" })
km("n", "<leader>gb", fzf.git_branches, { desc = "FZF: Git Branches" })
km("n", "<leader>ga", fzf.git_blame, { desc = "FZF: Git Blame" })
km("n", "<leader>gc", fzf.git_commits, { desc = "FZF: Git Commits" })

-- Utilities
km("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
km("n", "<leader>ss", fzf.spell_suggest, { desc = "Spelling Suggestions" })
km("n", "<leader>sc", fzf.spellcheck, { desc = "Spelling Check" })

-- LSP References
km('n', '<leader>gr', fzf.lsp_references, { desc = 'FZF: LSP references' })
km('n', '<leader>gd', fzf.lsp_definitions, { desc = 'FZF: LSP definitions' })
km('n', '<leader>gi', fzf.lsp_implementations, { desc = 'FZF: LSP implementations' })
km('n', '<leader>gt', fzf.lsp_typedefs, { desc = 'FZF: LSP type defs' })

-- Buffer Navigation
km('n', '<leader>n', ':bn<cr>', { desc = 'Next Buffer' })
km('n', '<leader>p', ':bp<cr>', { desc = 'Previous Buffer' })
km('n', '<leader>x', ':bd<cr>', { desc = 'Close Buffer' })

-- Toggle Comment
km({ 'n' }, '<leader>/', 'gbc', { remap = true, desc = 'Toggle Comment Block' })
km({ 'n' }, '<leader>;', 'gcc', { remap = true, desc = 'Toggle Comment Line' })
km({ 'v' }, '<leader>/', '<Esc>:normal gvgb<CR>', { desc = 'Toggle Comment Block' })
km({ 'v' }, '<leader>;', '<Esc>:normal gvgc<CR>', { desc = 'Toggle Comment Line' })
