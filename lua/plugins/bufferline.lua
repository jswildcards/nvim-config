return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        show_close_icon = false,
        show_buffer_close_icon = false,
        buffer_close_icon = '',
        close_icon = '',
      },
    })
  end,
}
