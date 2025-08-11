require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "html", "cssls", "gopls" },
	automatic_installation = true,
}

-- 3) Common on_attach & capabilities
local on_attach = function(client, bufnr)
	-- example keymaps; customize as you like:
	local bufmap = function(mode, lhs, rhs)
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap=true, silent=true })
	end

	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	bufmap("n", "K",		"<cmd>lua vim.lsp.buf.hover()<CR>")
	bufmap("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require("lspconfig")

local function setup_server(name, opts)
    opts = vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, opts or {})
    lspconfig[name].setup(opts)
end

-- 5) Configure each server

-- clangd with a custom flag
setup_server("clangd", {
	cmd = { "clangd", "--function-arg-placeholders=0" },
})

-- Zig
setup_server("zls", {
	cmd = { "zls" },
	init_options = {
		enable_argument_placeholders = false,
	},
})

-- OLS
setup_server("ols", {
	cmd = { "ols" },
})
