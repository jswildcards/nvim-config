return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {'nvim-telescope/telescope-fzf-writer.nvim', opt = true },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = "▸ ",
        selection_caret = "",
        entry_prefix = "",
        layout_strategy = "vertical",
        layout_config = {
          width = { padding = 0 },
          height = { padding = 0 },
          preview_height = 0.75,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    })
    vim.cmd [[
      highlight TelescopePromptNormal guibg=#3c3836
      highlight TelescopePromptBorder guifg=#3c3836 guibg=#3c3836
      highlight TelescopePromptTitle guifg=#3c3836 guibg=#3c3836
      highlight TelescopeResultsNormal guibg=#282828
      highlight TelescopeResultsBorder guifg=#282828 guibg=#282828
      highlight TelescopeResultsTitle guifg=#282828 guibg=#282828
      highlight TelescopePreviewNormal guibg=#1d2021
      highlight TelescopePreviewBorder guifg=#1d2021 guibg=#1d2021
      highlight TelescopePreviewTitle guifg=#1d2021 guibg=#1d2021
    ]]
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fh", "<cmd>Telescope git_status<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
  }
}
