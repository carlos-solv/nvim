do
  vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  }

  vim.lsp.config("shopify_theme_ls", {
    cmd = { "shopify", "theme", "language-server" },
    filetypes = { "liquid" },
    init_options = {
      enableSchema = true,
      enableCompletions = true,
      enableSnippets = true,
      enableValidations = true,
    },
    flags = {
      debounce_text_changes = 150,
    },
    root_markers = {
      "shopify.theme.toml",
      ".shopifyignore",
      ".git",
    },
  })

  vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
  }

  vim.lsp.config.html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "templ", "eruby" },
    root_markers = { "package.json", ".git" },
  }

  vim.lsp.config.jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { "package.json", ".git" },
  }

  vim.lsp.config.emmet_ls = {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = {
      "html",
      "css",
      "scss",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
    root_markers = { "package.json", ".git" },
  }

  vim.lsp.config.prisma_language_server = {
    cmd = { "prisma-language-server", "--stdio" },
    filetypes = { "prisma" },
    root_markers = { "package.json", ".git" },
  }

  vim.lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  }

  vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
  },
  root_markers = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    "package.json",
    ".git",
  },
  settings = {
    validate = "on",
    workingDirectory = { mode = "location" },
    format = false,
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
    experimental = {
      useFlatConfig = false,
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source.fixAll.eslint" },
            diagnostics = {},
          },
          apply = true,
        })
      end,
    })
  end,
})


  vim.lsp.config.tailwindcss = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
    },
    root_markers = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "package.json",
      ".git",
    },
  }

  vim.lsp.config.ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  }

  vim.lsp.enable({
    "lua_ls",
    "shopify_theme_ls",
    "cssls",
    "html",
    "jsonls",
    "emmet_ls",
    "prisma_language_server",
    "gopls",
    "eslint",
    "tailwindcss",
    "ts_ls",
  })
end
