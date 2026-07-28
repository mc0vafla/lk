require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map('n', '<C-q>', ':q!<CR>', { desc = 'Quit' })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { 
    pos = "sp", 
    id = "horizTerm", 
    size = 0.45
  }
end, { desc = "Terminal toggle horizontal term" })
map({ "n", "t" }, "<C-d>", function()
  require("nvchad.term").toggle { 
    pos = "sp", 
    id = "horizTerm", 
    size = 0.45
  }
end, { desc = "Terminal toggle horizontal term" })
-- map({ "n", "t" }, "<C-d>", function()
--   require("nvchad.term").toggle { 
--     pos = "vsp", 
--     id = "vTermVertical", 
--     size = 0.40
--   }
-- end, { desc = "Terminal toggle vertical term" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { 
    pos = "vsp", 
    id = "vTermVertical", 
    size = 0.40
  }
end, { desc = "Terminal toggle vertical term" })

map({ "n", "t" }, "<A-Tab>", function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  if vim.bo[current_buf].buftype == "terminal" then
    vim.cmd("wincmd p") 
    return
  end
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      vim.cmd("startinsert") 
      return
    end
  end
  require("nvchad.term").toggle { pos = "sp", id = "vTerm", size = 0.45 }
end, { desc = "Terminal switch between code and term" })


map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
