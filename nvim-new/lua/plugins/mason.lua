return {
	{

		"mason-org/mason.nvim",
		priority = 1000,
		config = function()
			local mason = require("mason")
			mason.setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "pyright", "zls" },
			})
		end,
	},
}
