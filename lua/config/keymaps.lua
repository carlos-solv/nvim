local km = vim.keymap

km.set('n', '<leader>o', ':update<CR> :source<CR>')
km.set('n', '<leader>w', ':write<CR>')
km.set('n', '<leader>q', ':quit<CR>')

-- Language Formatting
km.set('n', '<leader>lf', vim.lsp.buf.format)

-- Open Diagnostic Floting Window
km.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic window' })

-- fzf-lua
km.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FZF Files" })
-- km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })
km.set("n", "<leader>fk", require("fzf-lua").keymaps, { desc = "Keymaps" })
km.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FZF Grep" })
km.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FZF Buffers" })
km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
km.set("n", "<leader>ss", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })
km.set("n", "<leader>sc", require("fzf-lua").spellcheck, { desc = "Spelling Check" })

-- Buffer Navigation
km.set('n', '<leader>n', ':bn<cr>')
km.set('n', '<leader>p', ':bp<cr>')
km.set('n', '<leader>x', ':bd<cr>')

-- Toggle Comment
km.set({'n','v'}, '<leader>/', ':CommentToggle<CR>')
