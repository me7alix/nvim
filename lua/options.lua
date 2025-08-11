vim.g.mapleader = ' '

vim.opt.fillchars:append { eob = " " }
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.expandtab	  = false
vim.opt.tabstop		  = 4
vim.opt.shiftwidth	  = 4
vim.opt.softtabstop   = 4
vim.opt.smarttab	  = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.list = true
vim.opt.listchars = {
	tab = '│ ',
	trail = '․',
}
