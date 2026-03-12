return {
	{ "nvim-lua/plenary.nvim", priority = 1000 },
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({})
		end,
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		dependencies = {},
		config = function()
			require("flutter-tools").setup({}) -- use defaults
		end,
	},
}
