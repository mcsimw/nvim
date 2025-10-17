return {
  {
    "nvim-lspconfig",
    lazy = false,
    after = function()
      -- Nix (nixd) config
      vim.lsp.config("nixd", {
        cmd = { "nixd" },
        filetypes = { "nix" },
        root_markers = { "flake.nix", ".git" },
      })
      vim.lsp.enable("nixd")
    end,
  },
}
