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

vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars:append {
  eol = '↵',
  tab = '▕░',
  trail = '█',
  multispace = '█',
  leadmultispace = '▏ ',
}
vim.opt.fillchars:append {
  eob = ' ',
  foldclose = '⮞',
  foldopen = '⮟',
  foldsep = ' ',
  fold = ' ',
}

vim.opt.updatetime = 100
vim.opt.termguicolors = true

-- motion
vim.opt.whichwrap:append '[,],<,>'
vim.opt.mouse = ''

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- fold
function _G.foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  return line
end

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 1
vim.opt.foldcolumn = '1'
vim.opt.foldtext = 'v:lua.foldtext()'

-- status column
local function get_fold(lnum)
  local fc = vim.opt.fillchars:get()
  local expr = vim.treesitter.foldexpr(lnum)

  if string.sub(expr, 1, 1) ~= '>' then
    return ' '
  end

  if vim.fn.foldclosed(lnum) ~= -1 then
    return fc.foldclose
  end

  return fc.foldopen
end

function _G.get_statuscol()
  if vim.v.virtnum > 0 then
    return ' '
  end

  return "%s%=%{%v:relnum?v:relnum:v:lnum%} " .. get_fold(vim.v.lnum) .. " "
end

vim.opt.statuscolumn = '%!v:lua.get_statuscol()'
