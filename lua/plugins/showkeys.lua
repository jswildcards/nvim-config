return {
  -- "nvzone/showkeys",
  -- config = function()
  --   local showkeys = require("showkeys")
  --   local state = require("showkeys.state")
  --   local utils = require("showkeys.utils")

  --   utils.gen_winconfig = function()
  --     state.config.winopts.width = state.w
  --   end

  --   showkeys.setup({
  --     timeout = 0.3,
  --     maxkeys = 1,
  --     winhl = "FloatBorder:WarningMsg,Normal:Normal",
  --     winopts = {
  --       focusable = false,
  --       relative = "cursor",
  --       style = "minimal",
  --       border = "double",
  --       height = 1,
  --       row = -3,
  --       col = 5,
  --       zindex = 200,
  --     },
  --   })

  --   -- vim.api.nvim_create_autocmd("User", {
  --   --   pattern = "ShowkeysKey",
  --   --   callback = function(ev)
  --   --     local key = ev.data.key or "?"
  --   --     vim.notify("💥 " .. key .. " 💥", "info", {
  --   --       title = "Key Explosion",
  --   --       icon = "🎆",
  --   --       timeout = 300,
  --   --     })
  --   --   end,
  --   -- })

  --   -- -- Save original draw
  --   -- local orig_draw = utils.draw

  --   -- -- Wrap draw to fire a User event
  --   -- utils.draw = function(...)
  --   --   -- Grab the last keystroke from showkeys state
  --   --   local last = state.keys[#state.keys]

  --   --   if last ~= nil then
  --   --     -- Fire a custom User event
  --   --     vim.api.nvim_exec_autocmds("User", {
  --   --       pattern = "ShowkeysKey",
  --   --       data = { key = last.key },
  --   --     })
  --   --   end

  --   --   -- Call the original draw
  --   --   return orig_draw(...)
  --   -- end

  --   showkeys.toggle()
  -- end,
}
