return {
	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			windows = {
				preview = false,
				width_focus = 40,
				width_nofocus = 20,
				width_preview = 80,
			},
			options = { use_as_default_explorer = false },
			mappings = {
				close = "q",
				go_in = "<CR>",
				go_in_plus = "l",
				go_out = "h",
				go_out_plus = "H",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		},
		config = function(_, opts)
			local mf = require("mini.files")
			mf.setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "minifiles",
				callback = function(args)
					vim.keymap.set("n", "<Esc>", function()
						mf.close()
					end, { buffer = args.buf, nowait = true })

					vim.keymap.set("n", ".", function()
						local show = not vim.g.minifiles_show_dotfiles
						vim.g.minifiles_show_dotfiles = show
						mf.refresh({
							content = {
								filter = show and nil or function(e)
									return not e.name:match("^%.")
								end,
							},
						})
					end, { buffer = args.buf, desc = "Toggle dotfiles" })

					vim.keymap.set("n", "p", function()
						mf.refresh({ windows = { preview = true } })
					end, { buffer = args.buf, nowait = true, desc = "Preview on" })

					vim.keymap.set("n", "P", function()
						mf.refresh({ windows = { preview = false } })
					end, { buffer = args.buf, nowait = true, desc = "Preview off" })
				end,
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function(ev)
					local bt, ft = vim.bo[ev.buf].buftype, vim.bo[ev.buf].filetype
					if ft ~= "minifiles" and bt == "" then
						pcall(mf.close)
					end
				end,
			})

			vim.keymap.set("n", "<leader>e", function()
				mf.open(vim.loop.cwd(), false)
			end, { desc = "Explorer (mini.files) CWD" })

			vim.keymap.set("n", "<leader>E", function()
				mf.open(vim.api.nvim_buf_get_name(0), false)
			end, { desc = "Explorer (mini.files) file" })
		end,
	},
}
