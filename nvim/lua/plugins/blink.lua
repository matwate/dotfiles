return {
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"saghen/blink.cmp",
    priority = 1000,
    lazy = false,
		version = "1.*",
		config = function()
			local opts = {
				keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },

				appearance = {
					nerd_font_variant = "mono",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				fuzzy = { implementation = "lua" },
			}
			require("blink.cmp").setup(opts)
		end,
	},
}
