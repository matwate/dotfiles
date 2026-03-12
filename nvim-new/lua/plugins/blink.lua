return {
	{
		"rafamadriz/friendly-snippets",
		lazy = false,
	},
	{
		"saghen/blink.cmp",
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
