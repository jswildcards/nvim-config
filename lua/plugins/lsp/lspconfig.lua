return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local navic = require("nvim-navic")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(e)
        local opts = { buffer = e.buf, noremap = true, silent = true, }
        vim.keymap.set("n", "<leader>gR", "<cmd>Telescope lsp_references<cr>", opts)
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)
        vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
      end
    })

    local servers = { 'ts_ls' }
    local capabilities = cmp_nvim_lsp.default_capabilities()

    for _, server in ipairs(servers) do
      vim.lsp.config[server] = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end
      }

      vim.lsp.enable('ts_ls')
    end
  end
}
