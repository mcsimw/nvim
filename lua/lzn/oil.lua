return {
  "oil.nvim",
  lazy = vim.fn.argc(-1) == 0,
  before = function()
    require("lz.n").trigger_load("mini.icons")
  end,
  after = function()
    require("oil").setup({
      keymaps = {
        ["<C-c>"] = false,
        ["<leader>o"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
    })
  end,
}
