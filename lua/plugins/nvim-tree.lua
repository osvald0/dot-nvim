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

				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					})
				end

				local function node_dir()
					local node = api.tree.get_node_under_cursor()
					if not node or not node.absolute_path then
						return nil
					end
					if node.type == "directory" then
						return node.absolute_path
					end
					return vim.fn.fnamemodify(node.absolute_path, ":h")
				end

				-- Snacks explorer style keys
				map("<BS>", api.tree.change_root_to_parent, "Up")
				map(".", api.tree.change_root_to_node, "Set Root")
				map("<C-c>", function()
					local dir = node_dir()
					if dir then
						api.tree.change_root(dir)
						vim.cmd.tcd(vim.fn.fnameescape(dir))
					end
				end, "Set Root and tcd")
				map("h", function()
					local node = api.tree.get_node_under_cursor()
					if node and node.type == "directory" and node.open then
						api.node.open.edit()
					else
						api.node.navigate.parent_close()
					end
				end, "Close Directory")
				map("l", api.node.open.edit, "Open")
				map("Z", api.tree.collapse_all, "Collapse All")
				map("?", api.tree.toggle_help, "Help")

				map("+", function()
					api.tree.resize({ relative = 5 })
				end, "Widen")
				map("-", function()
					api.tree.resize({ relative = -5 })
				end, "Narrow")
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
