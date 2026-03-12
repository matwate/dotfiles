return {
	"chomosuke/typst-preview.nvim",
	event = "FileType",
	config = function()
		local opts = {}
		require("typst-preview").setup(opts)
	end,
}
