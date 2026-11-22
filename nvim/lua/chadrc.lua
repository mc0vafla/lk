---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "vscode_dark",
    hl_override = {
        Normal       = { bg = "#282828", fg = "#d3c6aa" },
        NormalNC     = { bg = "#282828", fg = "#d3c6aa" },
        SignColumn   = { bg = "#282828" },
        Cursor       = { bg = "#e67e80", fg = "#282828" },
        
        NvimTreeNormal        = { bg = "#282828", fg = "#d3c6aa" },
        NvimTreeNormalNC      = { bg = "#282828", fg = "#d3c6aa" },
        NvimTreeEndOfBuffer   = { bg = "#282828", fg = "#282828" },
        NvimTreeWinSeparator  = { bg = "#282828", fg = "#5c4b4b" },

        Identifier   = { fg = "#e68d80" },
        Statement    = { fg = "#e68d80" },
        Constant     = { fg = "#e6a080" },
        String       = { fg = "#e68d80" },
        Function     = { fg = "#e680a0" },
        Type         = { fg = "#e6a080" },
        Special      = { fg = "#e680c0" },
        Comment      = { fg = "#5c4b4b" },
        Directory    = { fg = "#e68080", bold = true },
        LineNr       = { fg = "#5c4b4b" },
        CursorLineNr = { fg = "#e67e80", bold = true },

        NvimTreeOpenedFile     = { fg = "#e68d80", bold = true },
        NvimTreeFolderIcon     = { fg = "#e680a0" },
        NvimTreeFolderName     = { fg = "#e680a0" },
        NvimTreeOpenedFolderName = { fg = "#e68d80", bold = true },
        NvimTreeRootFolder     = { fg = "#e67e80", bold = true },
        NvimTreeSpecialFile    = { fg = "#e680c0", underline = true },
        NvimTreeImageFile      = { fg = "#e68080" },
        NvimTreeSymlink        = { fg = "#e68080" },

        DiagnosticError        = { fg = "#e67e80" },
        DiagnosticWarn         = { fg = "#e6a080" },
        DiagnosticInfo         = { fg = "#e680a0" },
        DiagnosticHint         = { fg = "#e68080" },
    },
}

return M
