-- Override LSP capabilities to include blink.cmp completion capabilities
-- This runs after all plugins are loaded

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Override capabilities for servers enabled with vim.lsp.enable()
local servers = { 'lua_ls', 'gopls', 'pyright' }

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end


