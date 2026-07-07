return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			renderer = {
				root_folder_label = ":t",
				highlight_opened_files = "name",
				icons = {
					glyphs = {
						folder = {
							arrow_closed = ">",
							arrow_open = "⌄",
						},
					},
				},
			},
			update_focused_file = { enable = true, update_root = false },
			filters = { dotfiles = true },
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

		local function set_arrow_hl()
			vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#7d5ba6" })
			vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#7d5ba6" })
		end
		set_arrow_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_arrow_hl })
	end,
}
