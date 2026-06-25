return {
  -- "VonHeikemen/lsp-zero.nvim",
  -- branch = "v3.x",
  -- dependencies = {
  --   {"neovim/nvim-lspconfig"},
  --   {"williamboman/mason.nvim"},
  --   {"williamboman/mason-lspconfig.nvim"},
  --   {"hrsh7th/nvim-cmp"},
  --   {"hrsh7th/cmp-nvim-lsp"},
  --   {"L3MON4D3/LuaSnip"},
  -- },
  -- config = function()
  --   local lsp_zero = require('lsp-zero')

  --   lsp_zero.preset('recommended')

  --   require('mason').setup({})

  --   require('mason-lspconfig').setup({
  --     ensure_installed = {
  --       'ts_ls',  -- TypeScript / JavaScript
  --     },
  --     handlers = {
  --       function(server_name)
  --         if server_name ~= 'jdtls' then
  --           lsp_zero.default_setup(server_name)
  --         end
  --       end
  --     }
  --   })

  --   -- Attach default keymaps when a server starts
  --   lsp_zero.on_attach(function(client, bufnr)
  --     -- This sets up default LSP keymaps (rename, code actions, etc.)
  --     lsp_zero.default_keymaps({buffer = bufnr})

  --     -- You can also add your own custom ones here:
  --     local opts = {buffer = bufnr, remap = false}
  --     vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
  --     vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
  --     vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)
  --     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  --     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  --     vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
  --   end)

  --   -- lsp_zero.nvim_workspace()
  --   lsp_zero.setup()
  -- end,
}
