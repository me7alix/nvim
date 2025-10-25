require('outline').setup({
	outline_window = {
		position = 'right',
		auto_close = true,
		auto_jump = false,
	},

	keymaps = {
		show_outline = false,
	},
})

vim.keymap.set('n', '<leader>s', function()
	require('outline').open()
end, { desc = 'Open Outline' })
