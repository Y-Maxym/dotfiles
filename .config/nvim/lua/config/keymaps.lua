-- Leader key: Space (must be set before any mapping that uses <leader>)
vim.g.mapleader = ' '

-- Files

vim.keymap.set('n', '<leader>w', '<Cmd>write<CR>', { desc = 'Save file' })

-- Search (fzf-lua)

-- Find a file by name
vim.keymap.set('n', '<leader>ff', '<Cmd>FzfLua files<CR>', { desc = 'Find files' })
-- Search text in all files of the project (rg)
vim.keymap.set('n', '<leader>fg', '<Cmd>FzfLua live_grep<CR>', { desc = 'Grep text' })
-- Switch between open buffers
vim.keymap.set('n', '<leader>fb', '<Cmd>FzfLua buffers<CR>', { desc = 'Buffers' })
-- Recently opened files
vim.keymap.set('n', '<leader>fo', '<Cmd>FzfLua oldfiles<CR>', { desc = 'Recent files' })

-- Code

-- Format the whole file with the language server (ruff for Python, lua_ls for Lua)
vim.keymap.set('n', '<leader>fm', function()
  vim.lsp.buf.format()
end, { desc = 'Format file' })
