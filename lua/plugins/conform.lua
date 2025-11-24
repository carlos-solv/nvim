return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua             = { "stylua", lsp_format = "fallback" },
      python          = { "isort", "black", lsp_format = "fallback" },
      rust            = { "rustfmt", lsp_format = "fallback" },
      go              = { "gofmt", lsp_format = "fallback" },
      javascript      = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      css             = { "prettierd", "prettier", stop_after_first = true },
      typescript      = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      liquid          = { "prettierd", "prettier", stop_after_first = true },
      json            = { "prettierd", "prettier", stop_after_first = true }
    },
    format_on_save = false,
  },
}
