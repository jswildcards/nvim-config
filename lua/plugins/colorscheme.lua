return {
  "sainnhe/gruvbox-material",
  name = "colorscheme",
  priority = 1000,
  config = function()
    vim.o.background = 'light'
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_transparent_background = 2
    vim.cmd.colorscheme("gruvbox-material")
  end
}
