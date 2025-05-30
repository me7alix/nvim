require "nvchad.mappings"

local map = vim.keymap.set
map({ "v", "x" }, "p", [["_dP]], { silent = true })
map({ "v", "x" }, "P", [["_dp]], { silent = true })
map("n", "d", '"_d')
map("v", "d", '"_d')
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
