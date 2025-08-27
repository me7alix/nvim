local M = {}

local function project_root()
	local git_root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')[1]
	if git_root and git_root ~= '' then
		return git_root
	end
	return vim.fn.getcwd()
end

local function open_result_at_cursor()
	local line = vim.api.nvim_get_current_line()
	local path, lnum = line:match('^(.-):(%d+):')
	if not path or not lnum then
		vim.notify('Could not parse grep result line', vim.log.levels.WARN)
		return
	end
	local root = vim.b.grep_root or vim.fn.getcwd()
	local fullpath = root .. '/' .. path
	if vim.fn.filereadable(fullpath) == 0 then
		vim.notify('File not found: ' .. fullpath, vim.log.levels.ERROR)
		return
	end
	vim.cmd('wincmd p')
	vim.cmd('edit ' .. vim.fn.fnameescape(fullpath))
	vim.api.nvim_win_set_cursor(0, { tonumber(lnum), 0 })
end

local function grep_open(pattern)
	if not pattern or pattern == '' then
		vim.notify('Usage: :Grep <pattern>', vim.log.levels.INFO)
		return
	end

	local root = project_root()
	local cmd = string.format("cd %s && grep -rn --color=never --exclude-dir=.git -F -e %s .",
	vim.fn.shellescape(root),
	vim.fn.shellescape(pattern)
)
local results = vim.fn.systemlist(cmd)

vim.cmd('belowright 12split')

local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_win_set_buf(0, buf)

vim.bo[buf].buftype = 'nofile'
vim.bo[buf].bufhidden = 'wipe'
vim.bo[buf].swapfile = false
vim.bo[buf].modifiable = true
vim.api.nvim_buf_set_name(buf, 'Grep: ' .. pattern)

if not results or vim.tbl_isempty(results) then
	results = { '-- no matches --' }
end
vim.api.nvim_buf_set_lines(buf, 0, -1, false, results)
vim.bo[buf].modifiable = false
vim.bo[buf].filetype = 'grep'

vim.b[buf].grep_root = root
vim.b[buf].grep_pattern = pattern

local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '<Cmd>lua require(\"todo\").open_result()<CR>', opts)
vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>bd!<CR>', opts)
end


function M.open_result()
	open_result_at_cursor()
end

vim.api.nvim_create_user_command('Grep', function(opts)
	grep_open(table.concat(opts.fargs, ' '))
end, { nargs = '+', desc = 'Project grep (git root or cwd)' })

return M
