require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "html", "cssls", "gopls", "clangd", "zls", "ols" },
})

-- Enhanced client capabilities (same as your original)
local caps = vim.lsp.protocol.make_client_capabilities()

-- Global keymappings via LspAttach (applies to ANY LSP server that attaches)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local bufmap = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
		end

		bufmap("n", "gd", vim.lsp.buf.definition)
		bufmap("n", "K", vim.lsp.buf.hover)
		bufmap("n", "<leader>r", vim.lsp.buf.rename)
	end,
})

-- Custom server configs (full control, including your overrides + filetypes + root_dir + capabilities)
local custom_servers = {
	clangd = {
		cmd = { "clangd", "--function-arg-placeholders=0" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git" }, { upward = true })[1]),
		capabilities = caps,
	},
	zls = {
		cmd = { "zls" },
		filetypes = { "zig" },
		root_dir = vim.fs.dirname(vim.fs.find({ "build.zig", "zig.mod", ".git" }, { upward = true })[1]),
		init_options = {
			enable_argument_placeholders = false,
		},
		capabilities = caps,
	},
	ols = {  -- Assuming OLS = Odin Language Server; adjust filetypes if wrong
		cmd = { "ols" },
		filetypes = { "odin" },
		root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
		capabilities = caps,
	},
}

-- Register + enable custom servers
for name, config in pairs(custom_servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

-- Built-in servers (Neovim 0.11+ provides defaults for cmd, filetypes, root_dir, etc.)
-- html, cssls, gopls have built-ins → just enable them (mason ensures binaries in $PATH)
local builtin_servers = { "html", "cssls", "gopls" }
for _, name in ipairs(builtin_servers) do
	vim.lsp.enable(name)
end
