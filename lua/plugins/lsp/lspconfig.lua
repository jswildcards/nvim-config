return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local navic = require("nvim-navic")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(e)
        local opts = { buffer = e.buf, noremap = true, silent = true, }
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      end
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            navic.attach(client, bufnr)
          end
        })
      end,
    })
  end
}
