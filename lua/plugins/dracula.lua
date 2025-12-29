return {
	{
		"Mofiqul/dracula.nvim",
		priority = 1000, -- load first
		lazy = false, -- do not lazy-load the colorscheme
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},
}
