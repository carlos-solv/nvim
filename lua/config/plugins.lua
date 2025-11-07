vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- packer
    
    use {
        'catppuccin/nvim', 
        as = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                background = {
                    light = 'latte',
                    dark = 'mocha'
                },
            })
            vim.cmd("colorscheme catppuccin")
        end
    }
    
    use {
         'ibhagwan/fzf-lua',
         opt = true,
         requires = {
             {'nvim-tree/nvim-web-devicons'}
         }
    }
end)
