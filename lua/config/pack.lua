local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("nvim-lua/plenary.nvim"),                       name = "plenary.nvim" },
  { src = gh("nvim-tree/nvim-web-devicons"),                 name = "nvim-web-devicons" },

  { src = gh("andymass/vim-matchup"),                        name = "vim-matchup" },
  { src = gh("nvim-lualine/lualine.nvim"),                   name = "lualine.nvim" },
  { src = gh("lukas-reineke/indent-blankline.nvim"),         name = "indent-blankline.nvim" },
  { src = gh("ibhagwan/fzf-lua"),                            name = "fzf-lua" },
  { src = gh("stevearc/conform.nvim"),                       name = "conform.nvim" },
  { src = gh("numToStr/Comment.nvim"),                       name = "Comment.nvim" },
  { src = gh("JoosepAlviste/nvim-ts-context-commentstring"), name = "nvim-ts-context-commentstring" },
  { src = gh("catppuccin/nvim"),                             name = "catppuccin",                   version = "main" },
  { src = gh("akinsho/bufferline.nvim"),                     name = "bufferline.nvim" },
  { src = gh("windwp/nvim-ts-autotag"),                      name = "nvim-ts-autotag" },
  { src = gh("rmagatti/auto-session"),                       name = "auto-session" },
  { src = gh("windwp/nvim-autopairs"),                       name = "nvim-autopairs" },
  { src = gh("mason-org/mason.nvim"),                        name = "mason.nvim" },
  { src = gh("jmbuhr/otter.nvim"),                           name = "otter.nvim" },
  { src = gh("nvim-treesitter/nvim-treesitter"),             name = "nvim-treesitter",              version = "main" },
  { src = gh("folke/snacks.nvim"),                           name = "snacks.nvim" },
  { src = gh("coder/claudecode.nvim"),                       name = "claudecode.nvim" },
  { src = gh("LunarVim/bigfile.nvim"),                       name = "bigfile" }
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

require("bigfile").setup({
  filesize = 2,        -- size of the file in MiB, the plugin round file sizes to the closest MiB
  pattern = { "*" },   -- autocmd pattern or function see <### Overriding the detection of big files>
  features = {         -- features to disable
    "indent_blankline",
    "illuminate",
    "lsp",
    "treesitter",
    "syntax",
    "matchparen",
    "vimopts",
    "filetype",
  },
}
)


require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    fzf = true,
  },
})

vim.cmd.colorscheme("catppuccin")

-- sessions
require("auto-session").setup({
  suppressed_dirs = {
    "~/",
    "~/Projects",
    "~/Downloads",
    "/",
    "~/Documents/zettelkasten",
  },
})

-- treesitter
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

-- commentstring
vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({
  enable = true,
  enable_autocmd = false,
})

-- statusline
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

-- bufferline
local bufferline_highlights
if (vim.g.colors_name or ""):find("catppuccin") then
  bufferline_highlights = require("catppuccin.special.bufferline").get_theme()
end

require("bufferline").setup({
  highlights = bufferline_highlights,
})

-- indent guides
require("ibl").setup({})

-- fzf
require("fzf-lua").setup({
  file_ignore_patterns = { "%.git/" },
})

-- formatter
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

-- comments
do
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
end

-- autotag
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})

-- autopairs
require("nvim-autopairs").setup({})

-- mason
require("mason").setup({})

-- snacks
require("snacks").setup({
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

-- claudecode
require("claudecode").setup({
  terminal_cmd = nil,
  auto_start = true,
  focus_after_send = false,
  track_selection = true,
  visual_demotion_delay_ms = 50,

  terminal = {
    provider = "snacks",
    auto_close = true,
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

  cwd_provider = function(ctx)
    local ok, cwd = pcall(require, "claudecode.cwd")
    if ok then
      return cwd.git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
    end
    return ctx.file_dir or ctx.cwd
  end,
})

-- otter for liquid
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

vim.api.nvim_create_augroup("my.otter.liquid", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "my.otter.liquid",
  pattern = "liquid",
  callback = function()
    vim.defer_fn(function()
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
