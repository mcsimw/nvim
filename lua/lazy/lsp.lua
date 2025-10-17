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

      -- Lua
      vim.lsp.config("lua_ls", {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            format = {
              enable = true,
            },
            runtime = {
              version = "LuaJIT",
            },
            telemetry = { enable = false },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              disable = { "missing-fields" },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}
