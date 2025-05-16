vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")


require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- c3 TS
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

-- vim stuff
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("v", "d", '"_d')

-- Use actual TAB characters
vim.opt.expandtab     = false
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4
vim.opt.softtabstop   = 4
vim.opt.smarttab      = true

-- retab
vim.keymap.set("n", "<leader>a", function()
  -- 1) save cursor
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- 2) retab and re-indent
  vim.cmd("retab!")
  vim.cmd("normal! gg=G")
  -- 3) restore cursor
  vim.api.nvim_win_set_cursor(0, {row, col})
end, { desc = "Fix tabs and re-indent file (without moving cursor)" })
