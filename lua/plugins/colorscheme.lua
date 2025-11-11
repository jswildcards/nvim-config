return {
  "sainnhe/gruvbox-material",
  name = "gruvbox",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_background = "medium"
    -- vim.g.gruvbox_material_foreground = "original"
    -- vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_transparent_background = 2
    vim.cmd.colorscheme("gruvbox-material")
  end
}
