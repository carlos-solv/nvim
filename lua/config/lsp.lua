do
  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })

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

  local function has_eslint_config(root)
    local names = {
      "eslint.config.js",
      "eslint.config.cjs",
      "eslint.config.mjs",
      "eslint.config.ts",
      "eslint.config.mts",
      "eslint.config.cts",
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml",
    }

    for _, name in ipairs(names) do
      if vim.uv.fs_stat(root .. "/" .. name) then
        return true
      end
    end
    return false
  end

  local function has_local_eslint(root)
    return vim.uv.fs_stat(root .. "/node_modules/eslint") ~= nil
  end

  vim.lsp.config('eslint', {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    root_dir = function(bufnr, on_dir)
      local path = vim.api.nvim_buf_get_name(bufnr)
      local root = vim.fs.root(path, {
        "eslint.config.js",
        "eslint.config.cjs",
        "eslint.config.mjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
      })

      if root and has_eslint_config(root) and has_local_eslint(root) then
        on_dir(root)
      end
    end,
    settings = {
      experimental = {},
      workingDirectories = { { mode = "auto" } },
    },
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
