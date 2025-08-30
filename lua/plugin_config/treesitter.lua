require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "lua", "odin", "go", "vim", "html", "css", "python" },

	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
}
