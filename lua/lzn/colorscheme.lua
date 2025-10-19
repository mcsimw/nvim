return {
  "vim-moonfly-colors",
  lazy = false,
  priority = 1000,
  after = function()
    vim.g.moonflyWinSeparator = 2
    require("moonfly").custom_colors({
      bg = "#000000",
    })
    vim.cmd.colorscheme("moonfly")
  end,
}
