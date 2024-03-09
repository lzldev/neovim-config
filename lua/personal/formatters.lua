local util = require 'formatter.util'

local M = {}

local rustywind = function(any)
  return {
    exe = 'rustywind',
    args = { '--stdin' },
    stdin = true,
 }
end


M.rustywind = rustywind

return M
