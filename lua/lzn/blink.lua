return {
  { "lspkind.nvim" },
  {
    "blink-cmp",
    event = "DeferredUIEnter",
    before = function()
      LZN.trigger_load("lazydev.nvim")
      LZN.trigger_load("lspkind.nvim")
      LZN.trigger_load("mini.icons")
    end,
    after = function()
      require("blink.cmp").setup({
        signature = { enabled = true },
        completion = {
          menu = {
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local mini_icon, _ = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_icon .. ctx.icon_gap
                      end
                    end

                    local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                    return icon .. ctx.icon_gap
                  end,

                  -- Optionally, use the highlight groups from mini.icons
                  -- You can also add the same function for `kind.highlight` if you want to
                  -- keep the highlight groups in sync with the icons.
                  highlight = function(ctx)
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_hl
                      end
                    end
                    return ctx.kind_hl
                  end,
                },
                kind = {
                  -- Optional, use highlights from mini.icons
                  highlight = function(ctx)
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_hl
                      end
                    end
                    return ctx.kind_hl
                  end,
                },
              },
            },
          },
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
