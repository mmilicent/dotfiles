local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
-- use if needed
-- local cmp_action = require('lsp-zero').cmp_action()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

-- here you can setup the language servers
require('mason').setup({})
require("mason-lspconfig").setup {
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { "lua_ls", "clangd"},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
}

cmp.setup({
    mapping = {
        -- navigate between items
        ['<M-k>'] = cmp.mapping.select_prev_item(),
        ['<M-j>'] = cmp.mapping.select_next_item(),

        -- confirm
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
    }
})

