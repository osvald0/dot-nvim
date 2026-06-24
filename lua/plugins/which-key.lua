return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 0,
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>h", group = "[H]unk (git)" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>b", group = "[B]uffer" },
				{ "<leader>x", group = "Trouble/Diagnostics" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
