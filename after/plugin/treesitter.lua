vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
  callback = function(event)
    local bufnr = event.buf

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    pcall(vim.treesitter.start, bufnr)

    vim.keymap.set({ "v", "n" }, "]]", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end, { buffer = bufnr })
    vim.keymap.set({ "v", "n" }, "[[", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end, { buffer = bufnr })
    vim.keymap.set({ "v", "n" }, "]a", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
    end, { buffer = bufnr })
    vim.keymap.set({ "v", "n" }, "[a", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
    end, { buffer = bufnr })
    vim.keymap.set({ "v", "n" }, "]A", function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end, { buffer = bufnr })
    vim.keymap.set({ "v", "n" }, "[A", function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
    end, { buffer = bufnr })
  end,
})
