-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chocolate", -- база, которую мы будем "подкрашивать"
  
  -- Переопределяем цвета (tokens) для соответствия твоей теме
  theme_tokens = {
      ["dark_bg"] = "#201818",
      ["statusline_bg"] = "#251c1c",
      ["accent"] = "#e67e80",
      ["red"] = "#e67e80",
      ["green"] = "#a7c080",
      ["yellow"] = "#dbbc7f",
  },

  -- Переопределяем конкретные группы подсветки (Highlights)
  hl_override = {
      Normal = { bg = "#201818", fg = "#d3c6aa" },
      NormalFloat = { bg = "#251c1c" },
      CursorLine = { bg = "#392b2b" }, -- твой любимый цвет для выделения
      StatusLine = { bg = "#251c1c", fg = "#d3c6aa" },
      TabLineSel = { bg = "#e67e80", fg = "#201818" },
      Pmenu = { bg = "#251c1c" },
      PmenuSel = { bg = "#392b2b", fg = "#e67e80" },
  },
}

return M
