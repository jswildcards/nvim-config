return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function(bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true, }

        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)

        vim.keymap.set(
          "n",
          "[c",
          function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk("prev")
            end
          end,
          opts
        )
        vim.keymap.set(
          "n",
          "]c",
          function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk("next")
            end
          end,
          opts
        )
      end,
    })
  end,
}
