return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- Label matches while searching with / and ? so you can jump
		-- straight to any result by pressing its label. Leave the built-in
		-- f/t/F/T motions untouched (flip char to true to label those too).
		modes = {
			char = { enabled = false },
			search = { enabled = true },
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
