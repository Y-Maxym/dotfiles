-- Yazi file manager in a floating window inside Neovim
return {
  'mikavilpas/yazi.nvim',
  -- Latest stable release instead of the main branch (as in the plugin README)
  version = '*',
  -- Loaded when the key below is pressed, no need to start it with Neovim
  keys = {
    -- Open yazi at the current file
    { '<leader>e', '<Cmd>Yazi<CR>', desc = 'File manager (yazi)' },
  },
}
