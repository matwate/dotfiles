return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols)
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		priority = 1000,
		lazy = false,
	},
}
