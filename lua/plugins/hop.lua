return {
  'smoka7/hop.nvim',
  version = "*",
  config = function()
    local hop = require('hop')
    local positions = require('hop.hint').HintPosition

    hop.setup { keys = 'etovxqpdygfblzhckisuran' }

    vim.keymap.set('', '<leader>jj', function()
      hop.hint_char2()
    end, { noremap = true, silent = true })

    vim.keymap.set('', '<leader>jk', function()
      hop.hint_patterns()
    end, { noremap = true, silent = true })
  end
}
