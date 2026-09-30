return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			image = {
				enabled = true,
				doc = {
					inline = true,
					float = true,
					max_width = 80,
					max_height = 40,
				},
			},
		},
		keys = {
			{
				"<leader>ih",
				function()
					Snacks.image.hover()
				end,
				desc = "Image hover",
			},
		},
	},
}
