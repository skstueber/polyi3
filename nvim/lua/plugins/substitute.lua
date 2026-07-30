return {
  "gbprod/substitute.nvim",
  config = function()
    require('substitute').setup({
      on_substitute = nil,
      yank_substituted_text = false,
      preserve_cursor_position = false,
      modifiers = nil,
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      },
      range = {
        prefix = "s",
        prompt_current_text = false,
        confirm = false,
        complete_word = false,
        subject = nil,
        range = nil,
        suffix = "",
        auto_apply = false,
        cursor_position = "end",
      },
      exchange = {
        motion = false,
        use_esc_to_cancel = true,
        preserve_cursor_position = false,
      },
    })
    vim.keymap.set("n", "<leader>bs", require('substitute').operator, { noremap = true })
    vim.keymap.set("n", "<leader>S", require('substitute').line, { noremap = true })
    vim.keymap.set("n", "<leader>sS", require('substitute').eol, { noremap = true })
    vim.keymap.set("x", "<leader>bs", require('substitute').visual, { noremap = true })

    vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
    vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
    vim.keymap.set("n", "<leader>su", require('substitute.range').word, { noremap = true })

    vim.keymap.set("n", "<leader>bx", require('substitute.exchange').operator, { noremap = true })
    vim.keymap.set("n", "<leader>X", require('substitute.exchange').line, { noremap = true })
    vim.keymap.set("x", "<leader>bx", require('substitute.exchange').visual, { noremap = true })
    vim.keymap.set("n", "<leader>xc", require('substitute.exchange').cancel, { noremap = true })
  end
}
