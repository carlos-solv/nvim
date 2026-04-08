local home = vim.fn.expand("~")

local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.cmd.packadd('nvim.undotree')

vim.pack.add({
  { src = gh("nvim-lua/plenary.nvim"),                       name = "plenary.nvim" },
  { src = gh("nvim-tree/nvim-web-devicons"),                 name = "nvim-web-devicons" },

  { src = gh("andymass/vim-matchup"),                        name = "vim-matchup" },
  { src = gh("obsidian-nvim/obsidian.nvim"),                 name = "obsidian.nvim" },
  { src = gh("nvim-tree/nvim-tree.lua"),                     name = "nvim-tree.lua" },
  { src = gh("iamcco/markdown-preview.nvim"),                name = "markdown-preview.nvim" },
  { src = gh("nvim-lualine/lualine.nvim"),                   name = "lualine.nvim" },
  { src = gh("lukas-reineke/indent-blankline.nvim"),         name = "indent-blankline.nvim" },
  { src = gh("ibhagwan/fzf-lua"),                            name = "fzf-lua" },
  { src = gh("stevearc/conform.nvim"),                       name = "conform.nvim" },
  { src = gh("numToStr/Comment.nvim"),                       name = "Comment.nvim" },
  { src = gh("JoosepAlviste/nvim-ts-context-commentstring"), name = "nvim-ts-context-commentstring" },
  { src = gh("brenoprata10/nvim-highlight-colors"),          name = "nvim-highlight-colors" },
  { src = gh("catppuccin/nvim"),                             name = "catppuccin",                   version = "main" },
  { src = gh("akinsho/bufferline.nvim"),                     name = "bufferline.nvim" },
  { src = gh("windwp/nvim-ts-autotag"),                      name = "nvim-ts-autotag" },
  { src = gh("rmagatti/auto-session"),                       name = "auto-session" },
  { src = gh("windwp/nvim-autopairs"),                       name = "nvim-autopairs" },

  -- keep only if you still want Mason to install binaries
  { src = gh("mason-org/mason.nvim"),                        name = "mason.nvim" },

  { src = gh("jmbuhr/otter.nvim"),                           name = "otter.nvim" },
  { src = gh("nvim-treesitter/nvim-treesitter"),             name = "nvim-treesitter",              version = "main" },
  { src = gh("folke/snacks.nvim"),                           name = "snacks.nvim" },
  { src = gh("coder/claudecode.nvim"),                       name = "claudecode.nvim" },
  { src = gh("saghen/blink.cmp"),                            name = "blink.cmp",                    version = "v1.10.2" },
})

local configured = {}

local function packadd(name)
  pcall(vim.cmd.packadd, name)
end

local function ensure(names)
  for _, name in ipairs(names or {}) do
    packadd(name)
  end
end

local function load_once(name, deps, config)
  if configured[name] then
    return
  end
  ensure(deps)
  packadd(name)
  configured[name] = true
  if config then
    config()
  end
end

local function lazy_event(events, pattern, name, deps, config)
  vim.api.nvim_create_autocmd(events, {
    pattern = pattern,
    callback = function()
      load_once(name, deps, config)
    end,
  })
end

local function lazy_ft(filetypes, name, deps, config)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
      load_once(name, deps, config)
    end,
  })
end

local function lazy_cmd(commands, name, deps, config)
  for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd, function(opts)
      load_once(name, deps, config)
      pcall(vim.api.nvim_del_user_command, cmd)
      vim.cmd(cmd .. (opts.bang and "!" or "") .. (opts.args ~= "" and (" " .. opts.args) or ""))
    end, {
      nargs = "*",
      bang = true,
    })
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    local path = ev.data.path

    if name == "markdown-preview.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "sh", "-c", "cd app && npm install && git restore ." }, { cwd = path }):wait()
    end

    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- ============================================================================
-- theme / ui
-- ============================================================================

load_once("catppuccin", nil, function()
  vim.o.termguicolors = true

  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      fzf = true,
      nvimtree = true,
    },
  })

  vim.cmd.colorscheme("catppuccin")
end)

load_once("auto-session", nil, function()
  require("auto-session").setup({
    suppressed_dirs = {
      "~/",
      "~/Projects",
      "~/Downloads",
      "/",
      "~/Documents/zettelkasten",
    },
  })
end)

load_once("nvim-treesitter", nil, function()
  require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  require("nvim-treesitter").install({
    "liquid",
    "html",
    "javascript",
    "css",
    "json",
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
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end)

load_once("nvim-ts-context-commentstring", { "nvim-treesitter" }, function()
  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable = true,
    enable_autocmd = false,
  })
end)

load_once("lualine.nvim", { "nvim-web-devicons" }, function()
  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 2 } },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  })
end)

load_once("bufferline.nvim", { "nvim-web-devicons", "catppuccin" }, function()
  local highlights
  if (vim.g.colors_name or ""):find("catppuccin") then
    highlights = require("catppuccin.special.bufferline").get_theme()
  end

  require("bufferline").setup({
    highlights = highlights,
  })
end)

load_once("mason.nvim", nil, function()
  require("mason").setup({})
end)

load_once("snacks.nvim", nil, function()
  require("snacks").setup({
    -- keep Snacks focused; don't replace tools you already use
    bigfile = { enabled = true },
    gitbrowse = { enabled = true },

    dashboard = { enabled = false },
    picker = { enabled = false },
    explorer = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    indent = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    image = { enabled = false },
  })
end)

load_once("claudecode.nvim", { "snacks.nvim" }, function()
  require("claudecode").setup({
    -- leave nil if `claude` is on your PATH
    -- if you use a local install, set it to "~/.claude/local/claude"
    terminal_cmd = nil,

    auto_start = true,
    focus_after_send = false,

    track_selection = true,
    visual_demotion_delay_ms = 50,

    terminal = {
      provider = "snacks",
      auto_close = true,

      --- use a right-side floating panel so it doesn't fight your normal splits
      ---@module "snacks"
      ---@type snacks.win.Config|{}
      snacks_win_opts = {
        position = "right",
        width = 0.42,
        height = 1.0,
        border = "rounded",
      },
    },

    diff_opts = {
      layout = "vertical",
      open_in_new_tab = false,
      keep_terminal_focus = false,
      hide_terminal_in_new_tab = false,
    },

    -- open Claude from the repo root when possible
    cwd_provider = function(ctx)
      local ok, cwd = pcall(require, "claudecode.cwd")
      if ok then
        return cwd.git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
      end
      return ctx.file_dir or ctx.cwd
    end,
  })
end)


-- ============================================================================
-- lazy plugins
-- ============================================================================

lazy_event({ "InsertEnter" }, "*", "blink.cmp", nil, function()
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        border = "rounded",
      },
      ghost_text = {
        enabled = false,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "vim-matchup")
lazy_event({ "InsertEnter" }, "*", "nvim-autopairs", nil, function()
  require("nvim-autopairs").setup({})
end)

lazy_event({ "BufReadPre", "BufNewFile" }, "*", "nvim-ts-autotag", { "nvim-treesitter" }, function()
  require("nvim-ts-autotag").setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "nvim-highlight-colors", nil, function()
  require("nvim-highlight-colors").setup({})
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "indent-blankline.nvim", nil, function()
  require("ibl").setup({})
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "fzf-lua", { "nvim-web-devicons" }, function()
  require("fzf-lua").setup({
    file_ignore_patterns = { "%.git/", "%.obsidian/" },
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "conform.nvim", nil, function()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua", lsp_format = "fallback" },
      python = { "isort", "black", lsp_format = "fallback" },
      rust = { "rustfmt", lsp_format = "fallback" },
      go = { "gofmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      liquid = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettier", lsp_format = "fallback" },
    },
    format_on_save = false,
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "Comment.nvim", {
  "nvim-ts-context-commentstring",
}, function()
  local U = require("Comment.utils")
  local ok_int, internal = pcall(require, "ts_context_commentstring.internal")
  local ok_utl, utils = pcall(require, "ts_context_commentstring.utils")

  require("Comment").setup({
    pre_hook = function(ctx)
      if not ok_int then
        return
      end

      local key = (ctx.ctype == U.ctype.linewise) and "__default" or "__multiline"
      local args = { key = key }

      if ok_utl then
        if ctx.ctype == U.ctype.blockwise then
          args.location = utils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          args.location = utils.get_visual_start_location()
        end
      end

      if vim.bo.filetype == "liquid" then
        local ts_cs = internal.calculate_commentstring(args)

        if (not ts_cs) or ts_cs:match("^<!%-%-") then
          return "{% comment %} %s {% endcomment %}"
        end

        return ts_cs
      end

      return internal.calculate_commentstring(args)
    end,
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*", "nvim-tree.lua", {
  "nvim-web-devicons",
}, function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.termguicolors = true

  require("nvim-tree").setup({
    view = { width = 30 },
    renderer = { group_empty = true },
    filters = { dotfiles = false },
  })
end)

lazy_event({ "BufReadPost", "BufNewFile" }, "*.liquid", "otter.nvim", {
  "nvim-treesitter",
}, function()
  require("otter").setup({
    buffers = {
      set_filetype = true,
      write_to_disk = false,
    },
    lsp = {
      diagnostic_update_events = { "BufWritePost", "TextChanged", "InsertLeave" },
      root_dir = function(_, bufnr)
        return vim.fs.root(bufnr or 0, {
          "shopify.theme.toml",
          ".shopifyignore",
          "package.json",
          ".git",
        }) or vim.fn.getcwd()
      end,
    },
  })

  local group = vim.api.nvim_create_augroup("my.otter.liquid", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "liquid",
    callback = function(args)
      vim.defer_fn(function()
        if not vim.api.nvim_buf_is_valid(args.buf) then
          return
        end

        vim.lsp.enable("shopify_theme_ls")

        require("otter").activate({
          "liquid",
          "html",
          "css",
          "javascript",
          "typescript",
          "json",
        }, true, true)
      end, 100)
    end,
  })
end)

lazy_event(
  { "BufReadPre", "BufNewFile" },
  {
    home .. "/Documents/vault/**.md",
    home .. "/Documents/zettelkasten/**.md",
  },
  "obsidian.nvim",
  { "plenary.nvim" },
  function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        { name = "zettelkasten", path = home .. "/Documents/zettelkasten" },
        { name = "vault",        path = home .. "/Documents/vault" },
      },
    })
  end
)

lazy_ft({ "markdown" }, "markdown-preview.nvim", nil, function()
  vim.g.mkdp_filetypes = { "markdown" }
end)

lazy_cmd(
  { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  "markdown-preview.nvim",
  nil,
  function()
    vim.g.mkdp_filetypes = { "markdown" }
  end
)
