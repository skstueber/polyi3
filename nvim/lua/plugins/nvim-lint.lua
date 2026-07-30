return {
  "mfussenegger/nvim-lint",
  event = { "BufNewFile", "BufReadPre", "BufWritePre" },
  opts = {
    linters_by_ft = {
      python = { "pylint" },
      javascript = { "eslint_d" },
      css = { "stylelint" },
      html = { "htmlhint" },
      sh = { "shellcheck" },
      c = { "cpplint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    vim.diagnostic.config({
      virtual_text = true,
    })

    vim.keymap.set('n', '<leader>gid', function()
      if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false)
      else
        vim.diagnostic.enable(true)
      end
    end)
  end,
}
