return {
	{ "nvim-lua/plenary.nvim" },
	{
		"ej-shafran/compile-mode.nvim",
		version = "latest",
		config = function()
			vim.g.compile_mode = {
				input_word_completion = true,
			}
		end,
	},
}
