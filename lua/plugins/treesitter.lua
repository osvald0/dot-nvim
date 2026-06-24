return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Pin to the legacy `master` branch. The default `main` branch is a
		-- breaking rewrite that removes the `nvim-treesitter.configs` API below.
		branch = "master",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		},
	},
}
