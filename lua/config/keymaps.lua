local km = vim.keymap

km.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Source File' })
km.set('n', '<leader>w', ':write<CR>', { desc = 'Write' })
km.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })

-- Language Formatting
km.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format File' })

-- Test Config
km.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Variable' })
km.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

-- Open Diagnostic Floting Window
km.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic window' })

-- fzf-lua
km.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FZF Files" })
km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })
km.set("n", "<leader>fo", require("fzf-lua").oldfiles, { desc = "Old Files" })
km.set("n", "<leader>fk", require("fzf-lua").keymaps, { desc = "Keymaps" })
km.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FZF Grep" })
km.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FZF Buffers" })
km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
km.set("n", "<leader>ss", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })
km.set("n", "<leader>sc", require("fzf-lua").spellcheck, { desc = "Spelling Check" })

-- Buffer Navigation
km.set('n', '<leader>n', ':bn<cr>', { desc = 'Next Buffer' })
km.set('n', '<leader>p', ':bp<cr>', { desc = 'Previous Buffer' })
km.set('n', '<leader>x', ':bd<cr>', { desc = 'Close Buffer' })

-- Toggle Comment
km.set({ 'n' }, '<leader>/', 'gbc', { remap = true, desc = 'Toggle Comment Block' })
km.set({ 'n' }, '<leader>;', 'gcc', { remap = true, desc = 'Toggle Comment Line' })
km.set({ 'v' }, '<leader>/', '<Esc>:normal gvgb<CR>', { desc = 'Toggle Comment Block' })
km.set({ 'v' }, '<leader>;', '<Esc>:normal gvgc<CR>', { desc = 'Toggle Comment Line' })
