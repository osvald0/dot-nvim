return {
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",

		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},
}
