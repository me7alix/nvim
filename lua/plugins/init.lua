return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require "configs.conform",
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			vim.cmd([[
		function OpenMarkdownPreview(url)
		execute "silent ! firefox --new-window " . a:url
		endfunction
		]])
			vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
			vim.keymap.set("n", "<C-a>", "<CMD>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
		end,
	},
	-- {
	--	"nvim-treesitter/nvim-treesitter",
	--	opts = {
	--		ensure_installed = {
	--			"vim", "lua", "vimdoc",
	--	  "html", "css"
	--		},
	--	},
	-- },
}
