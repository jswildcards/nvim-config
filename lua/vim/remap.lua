vim.g.mapleader = ','

-- general
vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { noremap = true, silent = true }) -- exit highlight search
vim.keymap.set('n', '\\', ',', { noremap = true, silent = true })                  -- reverse searching

-- buffer
vim.keymap.set('n', 'gb', '":<c-U>" . v:count1 . "bn<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'gB', '":<c-U>" . v:count1 . "bp<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', '<leader>b', '":<c-U>" . (v:count > 0 ? v:count : "") . "b<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', '<leader>q', '":<c-U>" . (v:count > 0 ? v:count : "") . "bd<cr>"', { noremap = true, silent = true, expr = true })

-- windows
vim.keymap.set('n', 'gw', '":<c-U>" . v:count1 . "wincmd w<cr>"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'gW', '":<c-U>" . v:count1 . "wincmd p<cr>"', { noremap = true, silent = true, expr = true })

-- space
vim.keymap.set('n', '<leader>et', ':setlocal et!<cr>', { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<leader>ls',
  '":<c-U>setlocal tabstop=" . v:count1 . " shiftwidth=" . v:count1 . " listchars=eol:↵,tab:▕░,trail:█,multispace:█,leadmultispace:▏" . repeat("\\\\ ", v:count1 - 1) . "<cr>"',
  { noremap = true, silent = true, expr = true }
)
