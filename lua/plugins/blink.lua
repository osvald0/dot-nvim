return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*", -- pin to stable API
		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = { preset = "default" },
			sources = {
				default = { "lsp", "path", "snippets" },
			},
			-- put docs config here to avoid the “Unexpected” error on newer versions
			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			signature = { enabled = true },
			fuzzy = { implementation = "lua" },
		},
	},
}
