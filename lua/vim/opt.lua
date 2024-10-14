-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftround = true

-- display
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars:append {
  eol = '↵',
  tab = '┠─',
  trail = '█',
  space = '·',
  leadmultispace = '▏·',
}
vim.opt.fillchars:append {
  eob = ' ',
  foldclose = '▸',
  foldopen = '▾',
  foldsep = '│',
  fold = ' ',
}

vim.opt.updatetime = 100

-- motion
vim.opt.whichwrap:append '[,],<,>'
vim.opt.mouse = ''

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true
