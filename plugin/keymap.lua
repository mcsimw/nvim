local set = vim.keymap.set

set("n", "<leader>ll", "<Cmd>bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>hh", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
