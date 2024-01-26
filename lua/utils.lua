local M = {}

function M.get_reveal_file_path()
  local reveal_file = vim.fn.expand '%:p'
  if reveal_file == '' then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, 'r')
    if f then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end

  return reveal_file
end

function M.is_first_buf()
  if vim.api.nvim_get_current_buf() == vim.api.nvim_list_bufs()[1]  then
    return true
  end
end

return M
