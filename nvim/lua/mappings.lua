require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map('n', '<C-q>', ':q!<CR>', { desc = 'Quit' })
map('n', '<C-w>', ':x<CR>', { desc = 'Save and quit' })

map({ "n", "t" }, "<C-d>", function()
  require("nvchad.term").toggle { 
    pos = "vsp", 
    id = "vTermVertical", 
    size = 0.2
  }
end, { desc = "Terminal toggle vertical term" })

map({ "n", "t", "i" }, "<C-x>", function()
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
  local has_hidden_term = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      has_hidden_term = true
      break
    end
  end
  if has_hidden_term then
    require("nvchad.term").toggle { pos = "vsp", id = "vTermVertical", size = 0.2 }
  else
    require("nvchad.term").toggle { pos = "vsp", id = "vTermVertical", size = 0.2 }
  end
end, { desc = "Terminal switch between code and term" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map('n', '<CR>', 'o<Esc>', { noremap = true, silent = true })
map('n', '<S-CR>', 'O<Esc>', { noremap = true, silent = true })

map('n', '<C-k>', '<C-y>', { silent = true })
map('n', '<C-j>', '<C-e>', { silent = true })

map({ "n", "t" }, "<M-l>", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[current_buf].filetype
  if vim.bo[current_buf].buftype == "terminal" then
    vim.cmd("vertical resize -3")
  elseif ft == "NvimTree" then
    vim.cmd("vertical resize +3")
  end
end, { desc = "Decrease width (Terminal / NvimTree)" })

map({ "n", "t" }, "<M-h>", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[current_buf].filetype
  if vim.bo[current_buf].buftype == "terminal" then
    vim.cmd("vertical resize +3")
  elseif ft == "NvimTree" then
    vim.cmd("vertical resize -3")
  end
end, { desc = "Increase width (Terminal / NvimTree)" })

map({ "n", "t", "i" }, "<C-a>", function()
  local ok_tree, api = pcall(require, "nvim-tree.api")
  if not ok_tree then return end
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local ft = vim.bo[current_buf].filetype
  if ft == "NvimTree" then
    vim.cmd("wincmd p")
    return
  end
  if api.tree.is_visible() then
    api.tree.focus()
    return
  end
  api.tree.open()
end, { desc = "Toggle focus between code and NvimTree" })
