return {
  "folke/flash.nvim",
  config = function()
    local flash = require('flash')

    flash.setup()
    flash.toggle()
  end
}
