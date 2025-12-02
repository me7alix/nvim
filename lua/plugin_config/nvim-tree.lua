vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup{
	view = {
		adaptive_size = true,
		width = 23,
	},
	renderer = {
		root_folder_label = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
}

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
