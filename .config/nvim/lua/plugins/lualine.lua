-- Statusline: mode, git branch, diagnostics, file info, cursor position
return {
  'nvim-lualine/lualine.nvim',
  opts = {
    -- Own theme: lua/lualine/themes/matugen.lua (transparent bar, colors from the colorscheme)
    options = { theme = 'matugen' },
  },
}
