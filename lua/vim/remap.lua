vim.g.mapleader = ','

-- general
vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { noremap = true, silent = true }) -- exit highlight search
vim.keymap.set('n', '\\', ',', { noremap = true, silent = true })                  -- reverse searching

-- buffer
vim.keymap.set('n', 'gb', '":<c-U>" . v:count1 . "bn<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'gB', '":<c-U>" . v:count1 . "bp<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', '<leader>b', '":<c-U>" . (v:count > 0 ? v:count : "") . "b<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', '<leader>q', '":<c-U>" . (v:count > 0 ? v:count : "") . "bd<cr>"', { noremap = true, silent = true, expr = true })

vim.keymap.set('n', '<leader>ls2', ':setlocal tabstop=2 shiftwidth=2 listchars=eol:↵,tab:┠─,trail:█,space:·,leadmultispace:▏·<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ls4', ':setlocal tabstop=4 shiftwidth=4 listchars=eol:↵,tab:┠─,trail:█,space:·,leadmultispace:▏···<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ls8', ':setlocal tabstop=8 shiftwidth=8 listchars=eol:↵,tab:┠─,trail:█,space:·,leadmultispace:▏·······<cr>', { noremap = true, silent = true })
