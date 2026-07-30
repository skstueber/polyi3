return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
        css = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        sh = { "shfmt" },
        c = { "clang-format" },
      }
    })
    vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, {})
  end
}
