return {
	"folke/trouble.nvim",
	opts = {}, -- use defaults; configure via keymaps below
	config = function(_, opts)
		require("trouble").setup(opts)
	end,
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
}
