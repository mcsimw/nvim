local set = vim.keymap.set

set("n", "<leader>bk", "<Cmd>bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>bj", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })


set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0,15)
end)
