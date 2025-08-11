vim.keymap.set('n', '<leader>t', function()
  local pattern = "TODO"
  local git_out = vim.fn.systemlist('git rev-parse --show-toplevel')
  local in_git = (vim.v.shell_error == 0 and git_out[1] and git_out[1] ~= '')
  local project_root = in_git and git_out[1] or vim.fn.getcwd()

  local cmd
  if in_git then
    cmd = 'git --no-pager grep -n --no-color -I -i -e ' .. vim.fn.shellescape(pattern)
  elseif vim.fn.executable('rg') == 1 then
    -- search everything, including ignored/hidden (useful while debugging)
    cmd = 'rg -n --hidden --no-ignore --no-ignore-vcs -S -i -e ' .. vim.fn.shellescape(pattern) .. ' .'
  else
    -- fallback: don't use --exclude-dir=".*" to avoid accidental over-exclusion
    cmd = 'grep -RInF --binary-files=text -i -e ' .. vim.fn.shellescape(pattern) .. ' .'
  end

  local full_cmd = 'cd ' .. vim.fn.shellescape(project_root) .. ' && ' .. cmd .. ' 2>/dev/null'
  local handle = io.popen(full_cmd)
  local output = handle and handle:read('*a') or ""
  if handle then handle:close() end

  if output == "" then
    vim.cmd('new')
    local buf = vim.api.nvim_get_current_buf()
    local info = {
      '=== TODO Search Debug ===',
      'Project root: ' .. project_root,
      'Command run: ' .. cmd,
      '',
      'Full shell command:',
      full_cmd,
      '',
      'Output:',
      output,
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, info)
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    return
  end

  local lines = vim.split(output, '\n')
  if #lines>0 and lines[#lines]=='' then table.remove(lines) end
  local items = {}
  for _,ln in ipairs(lines) do
    local path,lnum,text = ln:match('^(.*):(%d+):(.*)$')
    if path then
      local clean = path:gsub('^%./','')
      local abs = project_root .. '/' .. clean
      table.insert(items, { filename = abs, lnum = tonumber(lnum), text = text })
    end
  end
  if #items>0 then
    vim.fn.setqflist({}, ' ', { title = 'TODOs', items = items })
    vim.cmd('copen')
  else
    vim.notify('No TODOs found (check debug buffer)', vim.log.levels.INFO)
  end
end, { desc = 'Search for TODO items (debug-friendly)' })
