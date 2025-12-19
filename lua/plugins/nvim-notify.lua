return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup({
      stages = "fade_in_slide_out",
      timeout = 500,
      background_colour = "#000000",
      fps = 60,
    })
    vim.notify = notify

    -- vim.on_key(function(key)
    --   -- Filter out unprintable keys if you want
    --   if key == "" then return end

    --   if vim.fn.mode() ~= "c" then
    --     if key == ":" then return end  -- crude filter
    --   end

    --   -- Explosion popup for each keystroke
    --   vim.notify("💥 " .. key .. " 💥", "info", {
    --     title = "Key Explosion",
    --     icon = "🎆",
    --     timeout = 300,
    --   })
    -- end, ns)
  end,
}
