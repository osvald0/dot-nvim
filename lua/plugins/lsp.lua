return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		{ "Bilal2453/luvit-meta", lazy = true },
		"b0o/schemastore.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")

		-- Mason explicit setup (order-safe)
		local mason_ok, mason = pcall(require, "mason")
		if mason_ok and mason.setup then
			mason.setup({})
		end
		local mlsp_ok, mlsp = pcall(require, "mason-lspconfig")
		local mti_ok, mti = pcall(require, "mason-tool-installer")

		-- Capabilities (blink.cmp)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok_blink, blink = pcall(require, "blink.cmp")
		if ok_blink and blink.get_lsp_capabilities then
			capabilities = blink.get_lsp_capabilities(capabilities)
		end

		-- on_attach: minimal + keymaps (buffer-local)
		local on_attach = function(client, bufnr)
			-- Disable formatting from these servers
			local disable_fmt = { vtsls = true, tsserver = true, lua_ls = true, jsonls = true, yamlls = true }
			if disable_fmt[client.name] then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			-- Inlay hints (auto-enable if supported)
			if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
			end

			-- Buffer-local maps
			local function bmap(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
			end

			-- Prefer Telescope pickers when available
			local has_telescope, tb = pcall(require, "telescope.builtin")
			local def = has_telescope and tb.lsp_definitions or vim.lsp.buf.definition
			local refs = has_telescope and tb.lsp_references or vim.lsp.buf.references
			local impl = has_telescope and tb.lsp_implementations or vim.lsp.buf.implementation
			local tdef = has_telescope and tb.lsp_type_definitions or vim.lsp.buf.type_definition
			local dsym = has_telescope and tb.lsp_document_symbols or vim.lsp.buf.document_symbol
			local wsym = has_telescope and tb.lsp_workspace_symbols or vim.lsp.buf.workspace_symbol

			-- Core LSP
			bmap("n", "K", vim.lsp.buf.hover, "LSP: Hover")
			bmap("n", "gd", def, "LSP: Definition")
			bmap("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
			bmap("n", "gr", refs, "LSP: References")
			bmap("n", "gi", impl, "LSP: Implementations")
			bmap("n", "gT", tdef, "LSP: Type Definition")
			bmap("n", "gs", vim.lsp.buf.signature_help, "LSP: Signature Help")

			-- Actions / symbols / format
			bmap("n", "<leader>cr", vim.lsp.buf.rename, "LSP: Rename")
			bmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
			bmap("n", "<leader>ds", dsym, "LSP: Document Symbols")
			bmap("n", "<leader>ws", wsym, "LSP: Workspace Symbols")
			bmap("n", "<leader>cf", function()
				vim.lsp.buf.format({ async = false })
			end, "LSP: Format")

			-- Optional: toggle inlay hints
			bmap("n", "<leader>ci", function()
				local ih = vim.lsp.inlay_hint
				if not ih or not ih.is_enabled then
					return
				end
				local ok, enabled = pcall(ih.is_enabled, { bufnr = bufnr })
				if ok then
					ih.enable(not enabled, { bufnr = bufnr })
				end
			end, "LSP: Toggle Inlay Hints")
		end

		-- Servers
		local servers = {
			vtsls = {
				settings = {
					vtsls = { tsserver = { globalPlugins = {} }, autoUseWorkspaceTsdk = true },
					typescript = {
						inlayHints = { parameterNames = { enabled = "literals" }, variableTypes = { enabled = true } },
					},
					javascript = { inlayHints = { parameterNames = { enabled = "literals" } } },
				},
			},
			html = {},
			cssls = {},
			emmet_ls = { filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" } },
			tailwindcss = {},
			jsonls = {
				settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
			},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								vim.fn.expand("$VIMRUNTIME/lua"),
								vim.fn.stdpath("data") .. "/lazy/lazydev.nvim/types",
							},
						},
						diagnostics = { globals = { "vim" } },
					},
				},
			},
			bashls = {},
			dockerls = {},
			docker_compose_language_service = {},
			marksman = {},
			taplo = {},
		}

		-- Ensure tools via mason
		if mlsp_ok and mlsp.setup then
			mlsp.setup({ ensure_installed = vim.tbl_keys(servers) })
		end
		if mti_ok and mti.setup then
			mti.setup({ ensure_installed = { "prettierd", "prettier", "stylua", "shfmt", "eslint_d" } })
		end

		-- Helper to setup a server with our defaults
		local function setup_server(name)
			local cfg = servers[name] or {}
			cfg.capabilities = capabilities
			cfg.on_attach = on_attach
			cfg.flags = { debounce_text_changes = 150 }
			if lspconfig[name] then
				lspconfig[name].setup(cfg)
			end
		end

		-- Use setup_handlers when available, else manual fallback
		if mlsp_ok and type(mlsp.setup_handlers) == "function" then
			mlsp.setup_handlers({
				function(server_name)
					setup_server(server_name)
				end,
			})
		else
			local installed = {}
			if mlsp_ok and type(mlsp.get_installed_servers) == "function" then
				installed = mlsp.get_installed_servers() or {}
			end
			for _, name in ipairs(installed) do
				setup_server(name)
			end
			for name, _ in pairs(servers) do
				setup_server(name)
			end
		end

		-- Diagnostics UX
		vim.diagnostic.config({
			virtual_text = { spacing = 2, prefix = "●" },
			float = { border = "rounded" },
			severity_sort = true,
			signs = true,
			underline = true,
			update_in_insert = false,
		})

		-- Global diagnostic maps (define once)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Diag: Next" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Diag: Prev" })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true, desc = "Diag: Line Diagnostics" })
		vim.keymap.set("n", "<leader>dd", function()
			local ok, tb = pcall(require, "telescope.builtin")
			if ok then
				tb.diagnostics()
			else
				vim.diagnostic.setloclist()
			end
		end, { silent = true, desc = "Diag: List All" })
	end,
}
