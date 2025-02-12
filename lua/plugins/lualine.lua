return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local navic = require("nvim-navic")

    lualine.setup({
      options = {
        winbar = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_c = {{ 'filename', path = 1 }},
      },
      winbar = {
        lualine_a = {{ 'navic', color_correction = nil, navic_opts = nil }},
        lualine_x = {{ 'filename', path = 1 }},
      },
      inactive_winbar = {
        lualine_a = {{ 'navic', color_correction = nil, navic_opts = nil }},
        lualine_x = {{ 'filename', path = 1 }},
      },
    })
  end,
}
