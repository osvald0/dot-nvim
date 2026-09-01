return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Optional: install language servers
			local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
			if ok_mason then
				mason_lsp.setup({
					ensure_installed = { "lua_ls", "tsserver" }, -- package name still "tsserver"
				})
			end

			-- Capabilities from blink.cmp (if available)
			local capabilities
			do
				local ok_blink, blink = pcall(require, "blink.cmp")
				if ok_blink and type(blink.get_lsp_capabilities) == "function" then
					capabilities = blink.get_lsp_capabilities()
				end
			end

			-- Configure each server with the new API
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				-- put ts/tsx prefs here if you want
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = { completion = { callSnippet = "Replace" } },
				},
			})

			-- Enable servers (they’ll attach when you open matching files)
			vim.lsp.enable({ "ts_ls", "lua_ls" })
		end,
	},
}
