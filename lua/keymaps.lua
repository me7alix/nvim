local map = vim.keymap.set
map('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
map({ "v", "x" }, "p", [["_dP]], { silent = true })
map({ "v", "x" }, "P", [["_dp]], { silent = true })
-- map("n", "d", '"_d')
-- map("v", "d", '"_d')
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>a", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("retab!")
	vim.cmd("normal! gg=G")
	vim.api.nvim_win_set_cursor(0, {row, col})
end, { desc = "Fix tabs and re-indent file (without moving cursor)" })

map('n', '<C-h>', '<C-w>h', { noremap = true })
map('n', '<C-j>', '<C-w>j', { noremap = true })
map('n', '<C-k>', '<C-w>k', { noremap = true })
map('n', '<C-l>', '<C-w>l', { noremap = true })

map('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { noremap = true, silent = true })
