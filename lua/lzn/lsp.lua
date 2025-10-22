return {
  {
    "nvim-lspconfig",
    lazy = false,
    after = function()
      vim.lsp.enable({ "hls", "nixd", "lua_ls", "tinymist" })
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
    end,
  },
}
