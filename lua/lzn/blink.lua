return {
  {
    "blink-cmp",
    event = "DeferredUIEnter",
    before = function()
      LZN.trigger_load("lazydev.nvim")
      --      LZN.trigger_load("lspkind.nvim")
    end,
    after = function()
      require("blink.cmp").setup({
        signature = { enabled = true },
        completion = {
          menu = {
            auto_show = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            draw = {
              components = {},
              treesitter = { "lsp" },
            },
          },
          ghost_text = { enabled = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
        keymap = {
          preset = "none",
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          ["<Up>"] = { "snippet_forward", "fallback" },
          ["<Down>"] = { "snippet_backward", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },

          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        sources = {
          default = { "lazydev", "lsp", "buffer", "snippets", "path", "omni" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        fuzzy = { implementation = "rust" },
      })
    end,
  },
}
