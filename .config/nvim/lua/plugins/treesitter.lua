-- Treesitter: syntax highlighting from real grammars (parsers are built locally)
return {
  'nvim-treesitter/nvim-treesitter',
  -- The plugin does not support lazy-loading (README)
  lazy = false,
  -- After an update the parsers must be updated too, they are tied to the plugin version
  build = ':TSUpdate',
  config = function()
    -- Parsers for these languages are downloaded and compiled (no-op if already installed).
    -- c, lua, vim, vimdoc, query and markdown are already built into Neovim.
    require('nvim-treesitter').install({ 'bash', 'python', 'json', 'yaml', 'toml', 'java', 'lua' })

    -- Highlighting is a Neovim feature, the plugin only gives parsers and queries.
    -- It is not enabled by default, so start it for each opened file.
    -- pcall: filetypes without a parser (e.g. plain text) just keep the old regex syntax.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
