return {
  {
    "nvim-lspconfig",
    lazy = false,
    after = function()
      vim.lsp.enable({ "hls", "nixd", "lua_ls" })
    end,
  },
}
