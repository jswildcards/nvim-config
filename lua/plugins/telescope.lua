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
    local builtin = require("telescope.builtin")

    local function setup_defaults(fn)
      return function(opts)
        opts = opts or {}
        opts.results_title = ""
        opts.prompt_title = ""
        opts.preview_title = ""
        fn(opts)
      end
    end

    telescope.setup({
      defaults = {
        prompt_prefix = "▸ ",
        selection_caret = "",
        entry_prefix = "",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " ", },
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

    vim.keymap.set("n", "<leader>ff", setup_defaults(builtin.find_files), { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", setup_defaults(builtin.live_grep), { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fh", setup_defaults(builtin.git_status), { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fb", setup_defaults(builtin.buffers), { noremap = true, silent = true })
  end,
}
