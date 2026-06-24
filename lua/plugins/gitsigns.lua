return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation between hunks
				map("n", "]h", function()
					gs.nav_hunk("next")
				end, "Next Git hunk")
				map("n", "[h", function()
					gs.nav_hunk("prev")
				end, "Prev Git hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "[H]unk [S]tage")
				map("n", "<leader>hr", gs.reset_hunk, "[H]unk [R]eset")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[H]unk [S]tage (selection)")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "[H]unk [R]eset (selection)")
				map("n", "<leader>hp", gs.preview_hunk, "[H]unk [P]review")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "[H]unk [B]lame line")
				map("n", "<leader>hd", gs.diffthis, "[H]unk [D]iff against index")
				map("n", "<leader>tb", gs.toggle_current_line_blame, "[T]oggle line [B]lame")
			end,
		},
	},
}
