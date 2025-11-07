vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'HighLight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('hightlight-yank', {clear = true}),
    callback = function()
        vim.hightlight.on_yank()
    end
})

