return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			-- view = {
			-- 	hide_root_folder = true,
			-- },
			renderer = {
				root_folder_label = ":t",
				highlight_opened_files = "name",
			},
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			filters = {
				dotfiles = true,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "h", api.node.navigate.parent_close, {
					desc = "nvim-tree: Close Directory",
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				})
			end,
		})
	end,
}
