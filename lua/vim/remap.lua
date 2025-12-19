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
vim.keymap.set('n', 'gw', ':wincmd w<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'gW', ':wincmd W<cr>"', { noremap = true, silent = true })

-- space
vim.keymap.set('n', '<leader>et', ':setlocal et!<cr>', { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<leader>ls',
  '":<c-U>setlocal tabstop=" . v:count1 . " shiftwidth=" . v:count1 . " listchars=eol:↵,tab:▕░,trail:█,multispace:█,leadmultispace:▏" . repeat("\\\\ ", v:count1 - 1) . "<cr>"',
  { noremap = true, silent = true, expr = true }
)


-----------------------
-- REGION breakpoint --
-----------------------
local function create_jdb_breakpoint_cmd()
  local filename = vim.fn.expand('%:t')
  local classname = filename:gsub("%.java$", "")

  local package_name = nil
  for i = 1, vim.fn.line("$") do
    local line_text = vim.fn.getline(i)
    local pkg = line_text:match("^%s*package%s+([%w%.]+)%s*;")
    if pkg then
      package_name = pkg
      break
    end
  end

  local fqcn = classname
  if package_name then
    fqcn = package_name .. "." .. classname
  end

  local line_num = vim.fn.line('.')
  local cmd = "stop at " .. fqcn .. ":" .. line_num
  return cmd
end

vim.api.nvim_create_user_command("JdbBreakpoint", function()
  local cmd = create_jdb_breakpoint_cmd()
  print("Breakpoint Command: " .. cmd)
  vim.fn.setreg("+", cmd)
end, {})

vim.api.nvim_set_keymap("n", "<Leader>jb", ":JdbBreakpoint<CR>", { noremap = true, silent = false })
--------------------------
-- ENDREGION breakpoint --
--------------------------


-----------------
-- REGION path --
-----------------
local function get_remote_file_path_cmd()
  return vim.fn.expand('%:p')
end

vim.api.nvim_create_user_command("RemoteFilePath", function()
  local cmd = get_remote_file_path_cmd()
  print("Remote Path: " .. cmd)
  vim.fn.setreg("+", cmd)
end, {})

vim.api.nvim_set_keymap("n", "<Leader>pfr", ":RemoteFilePath<CR>", { noremap = true, silent = false })
--------------------
-- ENDREGION path --
--------------------


--------------------
-- REGION request --
--------------------
vim.keymap.set("n", ",req", function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result)
    if err or not result or not result.contents then return end
    local contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    local sig = table.concat(contents, "\n")

    local method = sig:match("%.([%w_]+)%(")

    local class = sig:match("([%w%.]+)%.[%w_]+%(")
    local shortClass = class:match("([%w_]+)$") or class
    local serviceId = shortClass:sub(1,1):lower() .. shortClass:sub(2)

    local params_str = sig:match("%((.*)%)")
    local param_objs = {}
    if params_str then
      for type,name in params_str:gmatch("([%w%.]+)%s+([%w_]+)") do
        local fqcn = type

        if type == "String" or type == "Long" or type == "Integer" or type == "Boolean" then
          fqcn = "java.lang." .. type
        else
          for _, l in ipairs(vim.fn.getbufline('%', 1, 50)) do
            local imp = l:match("^import%s+([%w%.]+%." .. type .. ");")
            if imp then
              fqcn = imp:gsub(";", "")
              break
            end
          end
        end

        local relpath = fqcn:gsub("%.", "/") .. ".java"
        local root = "/path/to/your/project/src/main/java/"
        local fname = root .. relpath

        if vim.fn.filereadable(fname) == 1 then
          local lines = vim.fn.readfile(fname)
          local qf_entries = {}

          for i, l in ipairs(lines) do
            -- Only show field declarations
            local ftype, fname = l:match("private%s+([%w%.<>]+)%s+([%w_]+)%s*;")
            if ftype and fname then
              table.insert(qf_entries, {
                filename = fname,
                lnum = i,
                text = ftype .. " " .. fname
              })
            end
          end

          if #qf_entries == 0 then
            -- fallback: show all lines
            for i, l in ipairs(lines) do
              table.insert(qf_entries, { filename = fname, lnum = i, text = l })
            end
          end

          vim.fn.setqflist(qf_entries, 'r')
          vim.cmd("copen")
        else
          print("DTO file not found: " .. fname)
        end

        local value = vim.fn.input(name .. " (" .. fqcn .. ")? ")
        local json_value
        if fqcn == "java.lang.Integer" or fqcn == "java.lang.Long" then
          json_value = value
        elseif fqcn == "java.lang.Boolean" then
          json_value = value:lower()
        elseif value:match("^%{.*%}$") or value:match("^%[.*%]$") then
          json_value = value
        else
          json_value = string.format("%q", value)
        end

        table.insert(param_objs, string.format(
          '{"Name":"%s","Type":"%s","Value":%s}',
          name, fqcn, json_value
        ))
      end
    end

    local joined = "[" .. table.concat(param_objs, ",") .. "]"
    local cmd = string.format(
      "ServiceId=%s MessageId=%s Params:='%s'",
      serviceId, method, joined
    )
    print("Built command:\n" .. cmd)
    vim.fn.setreg("+", cmd)
  end)
end)
-----------------------
-- ENDREGION request --
-----------------------
