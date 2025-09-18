-- Global variable to track the terminal buffer
local term_buf = nil
-- Function to toggle the terminal
function ToggleTerminal()
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		local win_id = vim.fn.bufwinid(term_buf)
		if win_id ~= -1 then
			-- Terminal is visible, hide it
			vim.api.nvim_win_close(win_id, false)
		else
			-- Terminal exists but hidden, show it below the current window
			vim.cmd('belowright split')
			vim.api.nvim_win_set_buf(0, term_buf)
			vim.cmd('resize 13')  -- Adjust height as needed
			vim.cmd('startinsert')
		end
	else
		-- Create a new terminal below the current window
		vim.cmd('belowright split')
		vim.cmd('terminal')
		vim.cmd('resize 13')  -- Adjust height as needed
		term_buf = vim.api.nvim_get_current_buf()
		-- Hide from bufferline (barbar)
		vim.opt_local.buflisted = false
		-- Set buffer-local keymap for terminal mode to toggle
		vim.api.nvim_buf_set_keymap(term_buf, 't', '<M-h>', '<C-\\><C-n>:lua ToggleTerminal()<CR>', { noremap = true, silent = true })
		vim.cmd('startinsert')
	end
end
-- Set global keymap in normal mode
vim.api.nvim_set_keymap('n', '<M-h>', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
-- Define the function globally so it can be called from :lua
function jump_to_error()
	local line = vim.fn.getline('.')
	local file, line_num, col
	-- Try different patterns
	-- Pattern 1: file:line:col:
	file, line_num, col = line:match('^([^:]+):(%d+):(%d+):')
	-- Pattern 2: file:line:
	if not file then
		file, line_num = line:match('^([^:]+):(%d+):')
	end
	-- Pattern 3: file(line,col)
	if not file then
		file, line_num, col = line:match('([^%(]+)%((%d+),(%d+)%)')
	end
	-- Add more patterns if needed
	if file and line_num then
		-- Trim any whitespace
		file = vim.trim(file)
		-- Check if file exists
		if vim.fn.filereadable(file) == 1 then
			-- Switch to the previous window (code window)
			vim.cmd('wincmd p')
			-- Edit in that window
			local cmd = 'edit +' .. line_num .. ' ' .. vim.fn.fnameescape(file)
			if col then
				cmd = cmd .. ' | normal! ' .. col .. '|'
			end
			vim.cmd(cmd)
			-- Optionally hide the terminal after jumping (uncomment if desired)
			-- vim.cmd('lua ToggleTerminal()')
		else
			-- Optionally notify
			-- vim.notify('File not found: ' .. file, vim.log.levels.WARN)
		end
	end
end
-- Set buffer-local keymap for normal mode in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':lua jump_to_error()<CR>', { noremap = true, silent = true })
	end
})
