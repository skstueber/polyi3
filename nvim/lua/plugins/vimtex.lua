return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    vim.keymap.set('n', '<localleader>lc', "<cmd>!latexclean<CR>")
    vim.g.vimtex_view_method = "mupdf"
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = 'aux',
      out_dir = 'pdfs',
    }
    vim.g.vimtex_compiler_clean_ext = {
      all = {
        'aux', 'bbl', 'blg', 'fdb_latexmk', 'fls', 'log', 'out', 'toc', 'gz', '*.synctex.gz'
      },
    }
    vim.g.vimtex_compiler_clean_paths = { 'aux/*'}
  end
}
