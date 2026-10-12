-- Indentation: 4 spaces instead of Tab characters

-- Width of a Tab character on screen
vim.opt.tabstop = 4
-- Width of one indent level (>>, <<, auto-indent)
vim.opt.shiftwidth = 4
-- Tab and Backspace in insert mode move by 4 columns
vim.opt.softtabstop = 4
-- Insert spaces instead of a Tab character
vim.opt.expandtab = true
-- Tab at the start of a line indents by shiftwidth (already on by default)
vim.opt.smarttab = true
-- Simple C-like auto-indent (no effect when 'indentexpr' is set)
vim.opt.smartindent = true

-- Mouse support (the default is "nvi")
vim.opt.mouse = 'a'

-- Line numbers and cursor context

-- Show the absolute number on the cursor line
vim.opt.number = true
-- Show the other numbers relative to the cursor (for counts like 5j, d3k)
vim.opt.relativenumber = true
-- Highlight the cursor line and its number
vim.opt.cursorline = true
-- Keep 8 lines of context above and below the cursor
vim.opt.scrolloff = 8

-- Long lines

-- Wrap long lines at word boundaries instead of in the middle of a word
vim.opt.linebreak = true
-- Keep the indent of the original line on wrapped parts
vim.opt.breakindent = true

-- Search

-- Ignore case in search patterns
vim.opt.ignorecase = true
-- ...unless the pattern contains an uppercase letter
vim.opt.smartcase = true

-- Clipboard

-- Use the system clipboard (register +) for yank, delete, change and paste
vim.opt.clipboard = 'unnamedplus'

-- Windows and undo history

-- Open vertical splits to the right of the current window
vim.opt.splitright = true
-- Open horizontal splits below the current window
vim.opt.splitbelow = true
-- Keep undo history between sessions (stored in the nvim state directory)
vim.opt.undofile = true

-- Statusline

-- The statusline shows the mode, so hide the "-- INSERT --" message below
vim.opt.showmode = false
