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
vim.opt.signcolumn = 'yes'

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
  local tabstop = vim.o.tabstop
  local spaces = string.rep(' ', tabstop)
  return line:gsub('\t', spaces) .. " …"
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

local function get_git_indicator(lnum)
  local ok, gitsigns = pcall(require, 'gitsigns')
  if not ok then return ' ' end

  local bufnr = vim.api.nvim_get_current_buf()
  local hunks = gitsigns.get_hunks(bufnr)
  if not hunks then return ' ' end

  for _, hunk in ipairs(hunks) do
    if hunk.type == 'add' and lnum >= hunk.added.start and lnum < hunk.added.start + hunk.added.count then
      return "%#GitSignsAdd#▕%*"
    end
    if hunk.type == 'change' and lnum >= hunk.added.start and lnum < hunk.added.start + hunk.added.count then
      return "%#GitSignsChange#▕%*"
    end
    if hunk.type == 'delete' and lnum == hunk.added.start then
      return "%#GitSignsDelete#▕%*"
    end
  end
  return ' '
end

function _G.get_statuscol()
  if vim.v.virtnum > 0 then
    return ' '
  end

  return "%s%=%{%v:relnum?v:relnum:v:lnum%} " .. get_fold(vim.v.lnum) .. " " .. get_git_indicator(vim.v.lnum)
end

vim.opt.statuscolumn = '%!v:lua.get_statuscol()'

-- sign
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "󰌶",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    }
  }
})

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-- keycast
local api = vim.api
local ns = api.nvim_create_namespace("keycast_float")

-- Keep track of the active window
local active_win = nil

local function make_buf(text)
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf, 0, -1, false, { text })
  return buf
end

local function show_key(key)
  -- Close previous window if still open
  if active_win and api.nvim_win_is_valid(active_win) then
    api.nvim_win_close(active_win, true)
    active_win = nil
  end

  local buf = make_buf(" " .. key .. " ")
  local row, col = unpack(api.nvim_win_get_cursor(0))

  local win = api.nvim_open_win(buf, false, {
    relative = "cursor",
    row = -5,
    col = 5,
    width = #key + 2,
    height = 1,
    style = "minimal",
    border = "double",
    focusable = false,
  })

  -- Remap highlights for this window
  vim.api.nvim_win_set_option(win, "winhl", "NormalFloat:Substitute,FloatBorder:WarningMsg")

  active_win = win

  -- Auto-close after 300ms
  vim.defer_fn(function()
    if api.nvim_win_is_valid(win) then
      api.nvim_win_close(win, true)
      if active_win == win then
        active_win = nil
      end
    end
  end, 300)
end

vim.on_key(function(key)
  if vim.fn.mode() == "c" then return end
  local display = vim.fn.keytrans(key)
  show_key(display)
end, ns)
