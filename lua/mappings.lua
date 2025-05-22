require "nvchad.mappings"

local map = vim.keymap.set

map("n", "d", '"_d')
map("v", "d", '"_d')
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
