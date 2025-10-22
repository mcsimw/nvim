return {
  "oil.nvim",
  lazy = false,
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
