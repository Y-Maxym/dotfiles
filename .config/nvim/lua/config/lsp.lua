-- Language servers. The servers themselves are installed with pacman,
-- the base definitions (cmd, filetypes, root markers) come from nvim-lspconfig.

-- Lua: tell the server this is Neovim (LuaJIT, vim.* API), otherwise it reports "undefined global vim"
vim.lsp.config('lua_ls', {
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    })
  end,
  settings = { Lua = {} },
})

-- Diagnostics: show the message text at the end of the line (off by default, signs and underline are on)
-- severity_sort: errors are shown before warnings when several are on one line
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Ruff gives lint and format, basedpyright gives types and navigation.
    -- Both answer hover (K): keep only basedpyright's, so K shows types (advice from the Ruff docs)
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    -- Completion menu from the server (built into Neovim, no plugin).
    -- autotrigger: the menu opens by itself after trigger characters like "." (set by the server)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

vim.lsp.enable({ 'lua_ls', 'bashls', 'basedpyright', 'ruff', 'jdtls' })
