return {
  {
    cmd = "Neogit",
    "neogit",
    before = function()
      LZN.trigger_load("plenary.nvim")
      LZN.trigger_load("fzf-lua")
      LZN.trigger_load("diffview.nvim")
    end,
  },
}
