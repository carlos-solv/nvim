return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").liquid = {
          install_info = {
            url = "https://github.com/hankthetank27/tree-sitter-liquid",
            branch = "main",
            files = { "src/parser.c", "src/scanner.c" },
            queries = "queries",
          },
        }
      end,
    })

    require("nvim-treesitter").install({
      "liquid",
      "html",
      "javascript",
      "css",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "xml",
      "go",
    })

    vim.treesitter.language.register("liquid", { "liquid" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "liquid",
        "html",
        "javascript",
        "css",
        "lua",
        "markdown",
        "python",
        "query",
        "svelte",
        "typescript",
        "tsx",
        "vue",
        "xml",
        "go",
        "vim",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "liquid",
        "html",
        "javascript",
        "css",
        "lua",
        "markdown",
        "python",
        "query",
        "svelte",
        "typescript",
        "tsx",
        "vue",
        "xml",
        "go",
        "vim",
      },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
