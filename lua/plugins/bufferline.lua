return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
	},
}
