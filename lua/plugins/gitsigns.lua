return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      signs = {
        add          = { text = '█' },
        change       = { text = '█' },
        delete       = { text = '█' },
        topdelete    = { text = '█' },
        changedelete = { text = '█' },
        untracked    = { text = '█' },
      },
      signs_staged = {
        add          = { text = '█' },
        change       = { text = '█' },
        delete       = { text = '█' },
        topdelete    = { text = '█' },
        changedelete = { text = '█' },
        untracked    = { text = '█' },
      },
      current_line_blame = true,
      current_line_blame_formatter = function(name, blame_info)
        local abbrev_sha  = blame_info.abbrev_sha
        local author_time = os.date('%y%m%d', tonumber(blame_info.author_time))
        local summary     = blame_info.summary

        -- Split into words
        local words = {}
        for word in blame_info.author:gmatch("%S+") do
          table.insert(words, word)
        end

        local initials = {}

        if #words >= 3 then
          -- Take first letter of first 3 words
          for i = 1, 3 do
            table.insert(initials, words[i]:sub(1,1))
          end
        elseif #words == 2 then
          -- First letters of both words
          table.insert(initials, words[1]:sub(1,1))
          table.insert(initials, words[2]:sub(1,1))
          -- Add next letter(s) from last word until length = 3
          local last = words[2]
          local idx = 2
          while #initials < 3 and idx <= #last do
            table.insert(initials, last:sub(idx,idx))
            idx = idx + 1
          end
        elseif #words == 1 then
          -- Just take first 3 letters of the single word
          local w = words[1]
          for i = 1, math.min(3, #w) do
            table.insert(initials, w:sub(i,i))
          end
        end

        local initials_str = table.concat(initials)

        local text = string.format('[%s]%s%s: %s',
          abbrev_sha,
          initials_str,
          author_time,
          summary
        )

        return { { text, "Comment" } }
      end,

      on_attach = function(bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true, }

        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, opts)
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)
        vim.keymap.set('n', '<leader>hB', gitsigns.toggle_current_line_blame, opts)
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, opts)
        vim.keymap.set('n', '<leader>hf', gitsigns.blame, opts)

        vim.keymap.set(
          'n',
          '<leader>hD',
          function()
            gitsigns.diffthis('~')
          end,
          opts
        )

        vim.keymap.set(
          'v',
          '<leader>hs',
          function()
            gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
          end,
          opts
        )
        vim.keymap.set(
          'v',
          '<leader>hr',
          function()
            gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
          end,
          opts
        )

        vim.keymap.set(
          'n',
          '<leader>hb',
          function()
            gitsigns.blame_line{full=true}
          end,
          opts
        )

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
