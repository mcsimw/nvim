return {
  {
    "nvim-lspconfig",
    lazy = false,
    after = function()
      vim.lsp.enable({ "hls", "nixd", "lua_ls", "tinymist", "clangd" })
    end,
  },
}
