return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local navic = require("nvim-navic")

    lualine.setup({
      sections = {
        lualine_c = {{ 'filename', path = 1 }},
      },
      winbar = {
        lualine_a = {{ 'navic', color_correction = nil, navic_opts = nil }}
      }
    })
  end,
}
