return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      end,
    },
  },

  {
    "nvim-lua/plenary.nvim", 
    event = "VimEnter",
    config = function()
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local ok_tree, api = pcall(require, "nvim-tree.api")
          if ok_tree and api.tree.is_visible() then
            api.tree.close()
          end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "terminal" then
              pcall(vim.api.nvim_win_close, win, true)
            end
          end
        end,
      })
    end,
  }
}
