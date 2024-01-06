local M = {}

-- Register a autocommand for highlighting text being yanked.
--   See `:help vim.highlight.on_yank()`  
-----
M.highlight_on_yank = function()
  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })
end

return M
