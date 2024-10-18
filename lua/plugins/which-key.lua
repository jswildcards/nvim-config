return {
  'folke/which-key.nvim',
  event = "VeryLazy",
  opts = {
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
    },
  }
}
