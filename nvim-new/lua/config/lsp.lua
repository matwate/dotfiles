-- Enable LSP servers for your main languages
local servers = { "lua_ls", "gopls", "pyright", "zls", "clangd", "jdtls", "rust-analyzer", "tinymist", "gleam" }

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local buf = event.buf
		local opts = { buffer = buf, remap = false }

		keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		keymap.set("n", "K", vim.lsp.buf.hover, opts)
		keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
		keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
