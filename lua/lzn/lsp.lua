return {
  {
    "nvim-lspconfig",
    lazy = false,
    after = function()
      vim.lsp.enable({ "nixd", "lua_ls" })
    end,
  },
}
