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

		-- on_attach
		local on_attach = function(client, bufnr)
			local disable_fmt = { vtsls = true, tsserver = true, lua_ls = true, jsonls = true, yamlls = true }
			if disable_fmt[client.name] then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
			end
			if client.name == "vtsls" then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						pcall(
							vim.lsp.buf.code_action,
							{ context = { only = { "source.organizeImports" } }, apply = true }
						)
					end,
				})
			end
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
	end,
}
