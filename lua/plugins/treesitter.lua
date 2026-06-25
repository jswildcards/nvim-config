return {
  "neovim-treesitter/nvim-treesitter",
  dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
  build = "TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.install {
      "java",
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "xml",
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        "*.java",
        "*.json",
        "*.js",
        "*.jsx",
        "*.ts",
        "*.tsx",
        "*.yaml",
        "*.html",
        "*.css",
        "*.xml",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
