-- Settings, keymaps, theme and the plugin manager live in lua/config/ and are loaded as modules
require('config.options')
require('config.keymaps')
-- Theme goes before lazy.nvim, so plugins that load later already see the colors
require('config.theme')
-- Must come after keymaps: the leader key has to be set before lazy.nvim loads
require('config.lazy')
-- Language servers: after lazy.nvim, so nvim-lspconfig definitions are already on the runtimepath
require('config.lsp')
