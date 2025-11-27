vim.g.mapleader = ' '

vim.opt.fillchars:append { eob = " " }
vim.opt.backspace   = '2'
vim.opt.showcmd     = true
vim.opt.laststatus  = 2
vim.opt.autowrite   = true
vim.opt.cursorline  = true
vim.opt.autoread    = true

vim.opt.expandtab   = false
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = 4
vim.opt.smarttab    = true

vim.opt.cinoptions:append(':0')
vim.opt.cinoptions:append('=0')

vim.api.nvim_create_user_command("ToggleTab", function()
	if vim.o.expandtab then
		vim.o.expandtab = false
		vim.o.softtabstop = 0
		vim.o.shiftwidth = 4
		vim.o.tabstop = 4
		vim.notify("Switched to Tabs mode", vim.log.levels.INFO)
	else
		vim.o.expandtab = true
		vim.o.softtabstop = 4
		vim.o.shiftwidth = 4
		vim.o.tabstop = 4
		vim.notify("Switched to Spaces mode", vim.log.levels.INFO)
	end
end, {})

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.opt.listchars = {
	tab = '» ',
	trail = '․',
}

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticError"})
vim.fn.sign_define("DiagnosticSignWarn",  {text = "", texthl = "DiagnosticWarn"})
vim.fn.sign_define("DiagnosticSignInfo",  {text = "", texthl = "DiagnosticInfo"})
vim.fn.sign_define("DiagnosticSignHint",  {text = "", texthl = "DiagnosticHint"})
