require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "lua", "odin", "go" },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
