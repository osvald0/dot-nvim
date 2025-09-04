return {
	{
		"echasnovski/mini.surround",
		version = false,
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				replace = "gsr",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				update_n_lines = "gsn",
				suffix_last = "l",
				suffix_next = "n",
			},
			n_lines = 50,
			search_method = "cover_or_next",
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
			local ok, wk = pcall(require, "which-key")

			if ok then
				wk.add({
					{ "gsa", desc = "Add surround", mode = { "n", "v" } },
					{ "gsd", desc = "Delete surround" },
					{ "gsr", desc = "Replace surround" },
					{ "gsf", desc = "Find right surround" },
					{ "gsF", desc = "Find left surround" },
					{ "gsh", desc = "Highlight surround" },
					{ "gsn", desc = "Update n_lines" },
				})
			end
		end,
	},
}
