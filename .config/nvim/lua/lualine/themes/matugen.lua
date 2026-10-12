-- lualine theme for the matugen colorscheme.
-- Colors are read from the highlight groups of that colorscheme, so the theme follows
-- the wallpaper. Only the mode pill is filled, the rest of the bar has no background.

-- Returns the "fg" or "bg" color of a highlight group as '#rrggbb' (or the fallback)
local function color(group, attr, fallback)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false, create = false })
  local value = hl and hl[attr]
  if type(value) == 'number' then
    return string.format('#%06x', value)
  end
  return value or fallback
end

local c = {
  accent    = color('TabLineSel', 'bg', '#a8c8ff'),
  on_accent = color('TabLineSel', 'fg', '#05305f'),
  fg        = color('Normal', 'fg', '#e1e2e9'),
  muted     = color('Comment', 'fg', '#c4c6cf'),
  green     = color('String', 'fg', '#81c995'),
  purple    = color('Number', 'fg', '#c58af9'),
  yellow    = color('Type', 'fg', '#fdd663'),
  red       = color('Error', 'fg', '#f28b82'),
}

-- Section a is the colored pill with the mode, b and c have a transparent background
local function mode(bg)
  return {
    a = { bg = bg, fg = c.on_accent, gui = 'bold' },
    b = { bg = 'NONE', fg = bg },
    c = { bg = 'NONE', fg = c.fg },
  }
end

local theme = {
  normal  = mode(c.accent),
  insert  = mode(c.green),
  visual  = mode(c.purple),
  replace = mode(c.red),
  command = mode(c.yellow),
  inactive = {
    a = { bg = 'NONE', fg = c.muted },
    b = { bg = 'NONE', fg = c.muted },
    c = { bg = 'NONE', fg = c.muted },
  },
}
theme.terminal = theme.command

return theme
