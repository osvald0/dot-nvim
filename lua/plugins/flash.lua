return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- Keep flash focused on labeled jumping only. Leave the built-in
		-- f/t/F/T motions and / search untouched (flip these to true to let
		-- flash label those too).
		modes = {
			char = { enabled = false },
			search = { enabled = false },
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
