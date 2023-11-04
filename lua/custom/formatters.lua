local util = require 'formatter.util'

local rustywind = function(any)
  return {
    exe = 'rustywind',
    args = { '--stdin' },
    stdin = true,
  }
end

local M = {}

M.rustywind = rustywind

return M
