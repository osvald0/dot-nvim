return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				-- Keep the tab bar clear of the nvim-tree panel (no divider line).
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = false,
					},
				},
				-- Flat, minimal look: no separator lines, no close buttons.
				separator_style = { "", "" },
				show_buffer_close_icons = false,
				show_close_icon = false,
				indicator = { style = "none" },
			},
		})

		-- Jump straight to a tab by its visible position.
		for i = 1, 9 do
			vim.keymap.set(
				"n",
				"<leader>" .. i,
				"<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
				{ desc = "Go to tab " .. i, noremap = true, silent = true }
			)
		end

		-- Pick a tab by pressing its shown letter (flash-style).
		vim.keymap.set(
			"n",
			"<leader>bp",
			"<cmd>BufferLinePick<CR>",
			{ desc = "Pick a tab to jump to", noremap = true, silent = true }
		)
	end,
}
