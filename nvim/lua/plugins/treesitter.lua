return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"java",
				"python",
				"bash",
				"html",
				"css",
				"javascript",
			},
			sync_install = false,
			highlight = {
				enable = true,
			},
			indent = {
        enable = true,
        disable = { "c" },
      },
		})
	end,
}
