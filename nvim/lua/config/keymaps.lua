---@diagnostic disable: undefined-global
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>qq", vim.cmd.q)
vim.keymap.set("n", "<leader>qw", vim.cmd.wq)

vim.keymap.set("i", "<C-i>", "<Esc>")
vim.cmd("inoremap <Tab> <Esc>")
vim.cmd("vnoremap <Tab> <Esc>")
-- vim.cmd("nnoremap <C-k> <C-w>k")
-- vim.cmd("nnoremap <C-j> <C-w>j")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set({ "n", "i" }, "<C-j>", "<C-w>j")
-- vim.keymap.set({ "n", "i" }, "<C-k>", "<C-w>k")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ma", ":make ", { silent = true })
vim.keymap.set("n", "<leader>r", function ()
  local file = vim.fn.input("Filename: ")
    vim.cmd("!./" .. file)
end, { silent = true })
