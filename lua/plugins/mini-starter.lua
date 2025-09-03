return {
	{
		"echasnovski/mini.starter",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			local starter = require("mini.starter")
			local ascii = [[ hello 🐧  ]]

			starter.setup({
				header = ascii,
				items = {
					{ name = "", action = "", section = "" },
				},
				footer = "",
				content_hooks = {
					starter.gen_hook.aligning("center", "center"),
				},
				evaluate_single = false,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local argc = vim.fn.argc()
					if argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1) then
						vim.schedule(function()
							vim.cmd("silent! %bwipeout!")
							starter.open()
							vim.opt_local.number = false
							vim.opt_local.relativenumber = false
						end)
					end
				end,
			})
		end,
	},
}
