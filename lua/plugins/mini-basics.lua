return {
	{ "echasnovski/mini.surround", version = false, opts = {} },
	{ "echasnovski/mini.comment", version = false, opts = {} },
	{ "echasnovski/mini.ai", version = false, opts = {} },
	{ "echasnovski/mini.tabline", version = false, opts = {} },
	{
		"echasnovski/mini.starter",
		version = false,
		opts = function()
			local s = require("mini.starter")
			return {
				evaluate_single = true,
				items = { s.sections.recent_files(5, false), s.sections.builtin_actions() },
				header = "neovim",
				footer = "",
				content_hooks = { s.gen_hook.adding_bullet("→ ", false), s.gen_hook.aligning("center", "center") },
			}
		end,
	},
}
