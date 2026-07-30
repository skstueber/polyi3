return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        pickers = {
          find_files = {
            layout_strategy = 'horizontal',
            layout_config = { preview_width = 0.6 }
          },
          live_grep = {
            layout_strategy = 'horizontal',
            layout_config = { preview_width = 0.6 }
          },
          help_tags = {
            layout_strategy = 'horizontal',
            layout_config = { preview_width = 0.6 }
          }
        }
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>gg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
