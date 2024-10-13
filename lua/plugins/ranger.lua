return {
  "kelly-lin/ranger.nvim",
  config = function()
    local ranger = require("ranger-nvim")

    ranger.setup()

    vim.api.nvim_set_keymap("n", "<leader>/", "", {
      noremap = true,
      callback = function()
        ranger.open(true)
      end,
    })
  end,
}
