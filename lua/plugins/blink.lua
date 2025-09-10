return {
	"saghen/blink.cmp",
	version = "v1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		keymap = { preset = "default" },
		sources = { default = { "lsp", "path", "buffer" } },
		fuzzy = { prebuilt_binaries = { download = true } },
	},
}
