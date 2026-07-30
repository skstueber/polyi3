return {
  "Mofiqul/dracula.nvim",
  name = "dracula",
  priority = 1000,
  config = function()
    require("dracula").setup()
    vim.cmd("colorscheme dracula")
    vim.cmd("hi LineNr guifg=#84de03 guibg=#44475a")
    vim.cmd("hi MatchParen guifg=#6272A4 guibg=#FFB86C")
  end
}
