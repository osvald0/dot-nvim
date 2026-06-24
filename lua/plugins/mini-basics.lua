return {
	{ "nvim-mini/mini.surround", version = false, opts = {} },
	{ "nvim-mini/mini.pairs", version = false, opts = {} },
	{ "nvim-mini/mini.comment", version = false, opts = {} },
	{ "nvim-mini/mini.ai", version = false, opts = {} },
	{ "nvim-mini/mini.statusline", version = false, opts = {} },
	{
		"nvim-mini/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "NvimTree", "help", "trouble", "lazy" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
