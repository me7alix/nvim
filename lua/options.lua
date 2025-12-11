vim.g.mapleader = " "

-- General options
local opt = vim.opt
opt.autowrite     = true
opt.autoread      = true
opt.showcmd       = true
opt.laststatus    = 2
opt.cursorline    = true
opt.backspace     = "2"
opt.fillchars:append { eob = " " }

-- Timings
vim.o.timeout     = true
vim.o.timeoutlen  = 300
vim.o.ttimeout    = true
vim.o.ttimeoutlen = 10

-- Indentation defaults (Tabs)
opt.expandtab     = false
opt.tabstop       = 4
opt.shiftwidth    = 4
opt.softtabstop   = 4
opt.smarttab      = true

-- Numbers
opt.number         = true
opt.relativenumber = true

-- Listchars
opt.list = true
opt.listchars = {
	tab = "» ",
	trail = "․",
}

vim.api.nvim_create_user_command("ToggleTab", function()
	local use_spaces = vim.o.expandtab

	vim.o.expandtab   = not use_spaces
	vim.o.softtabstop = 4
	vim.o.shiftwidth  = 4
	vim.o.tabstop     = 4

	local msg = use_spaces and "Switched to Tabs mode" or "Switched to Spaces mode"
	vim.notify(msg, vim.log.levels.INFO)
end, {})

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticError"})
vim.fn.sign_define("DiagnosticSignWarn",  {text = "", texthl = "DiagnosticWarn"})
vim.fn.sign_define("DiagnosticSignInfo",  {text = "", texthl = "DiagnosticInfo"})
vim.fn.sign_define("DiagnosticSignHint",  {text = "", texthl = "DiagnosticHint"})
