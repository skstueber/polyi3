vim.cmd("filetype on")
vim.cmd("syntax on")
vim.cmd("set number rnu")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.cmd("set expandtab")
vim.cmd("set autoindent")
-- vim.cmd("set cindent")
vim.cmd("autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab")
vim.cmd("set colorcolumn=80")

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 20

vim.opt.updatetime = 50
