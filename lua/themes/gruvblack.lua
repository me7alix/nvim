-- Credits to original https://github.com/morhetz/gruvbox
-- This is an AMOLED black version of Gruvbox theme for NvChad
local M = {}
M.base_30 = {
  white = "#ebdbb2",
  darker_black = "#000000", -- True AMOLED black
  black = "#000000", -- nvim bg (True AMOLED black)
  black2 = "#111111", -- Slightly lighter than pure black
  one_bg = "#151515", -- Very dark gray, almost black
  one_bg2 = "#202020", -- Dark gray
  one_bg3 = "#2a2a2a", -- Darker than original
  grey = "#353535", -- Darkened
  grey_fg = "#3a3a3a", -- Darkened
  grey_fg2 = "#404040", -- Darkened
  light_grey = "#505050", -- Darkened
  red = "#fb4934",
  baby_pink = "#cc241d",
  pink = "#ff75a0",
  line = "#121212", -- for lines like vertsplit (darker than original)
  green = "#b8bb26",
  vibrant_green = "#a9b665",
  nord_blue = "#83a598",
  blue = "#458588",
  yellow = "#d79921",
  sun = "#fabd2f",
  purple = "#b4bbc8",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#0a0a0a", -- Nearly black statusline
  lightbg = "#1a1a1a", -- Darkened
  pmenu_bg = "#83a598",
  folder_bg = "#749689",
}
M.base_16 = {
  base00 = "#000000", -- True AMOLED black for main background
  base01 = "#121212", -- Very dark gray
  base02 = "#1d1d1d", -- Darker than original
  base03 = "#252525", -- Darker than original
  base04 = "#bdae93",
  base05 = "#d5c4a1",
  base06 = "#ebdbb2",
  base07 = "#fbf1c7",
  base08 = "#fb4934",
  base09 = "#fe8019",
  base0A = "#fabd2f",
  base0B = "#b8bb26",
  base0C = "#8ec07c",
  base0D = "#83a598",
  base0E = "#d3869b",
  base0F = "#d65d0e",
}
M.type = "dark"
M = require("base46").override_theme(M, "gruvblack")
M.polish_hl = {
  syntax = {
    Operator = { fg = M.base_30.nord_blue },
  },
  treesitter = {
    ["@operator"] = { fg = M.base_30.nord_blue },
  },
}
return M
