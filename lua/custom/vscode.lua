vim.print '[STARTING VSCODE CONFIG]'

---------------------------------------------------------------------------------
--Setup lazy --------------------------------------------------------------------
---------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    { 'tpope/vim-surround' },
    {
      'smoka7/hop.nvim',
      opts = {},
    },
  },
}, {
  performance = {
    cache = {
      enabled = true,
    },
  },
})

vim.print 'LAZY SETUP FINISHED'

--------------------------------------------------------------------------------
-- Mappings --------------------------------------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-0>', '<C-6>', { silent = true, desc = ' go to alternate file ' })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- center after scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Write and quit all
vim.keymap.set('n', '<C-q>', vim.cmd.wqa, { silent = true })
vim.keymap.set('n', '<C-s>', vim.cmd.w, { silent = true })

vim.keymap.set('n', '<leader>c', function()
  vim.cmd 'q'
end, { silent = true, desc = 'Close Window' })

--------------------------------------------------------------------------------
-- CUSTOM VSCODE STUFF ---------------------------------------------------------
--------------------------------------------------------------------------------

local vscode = require 'vscode-neovim'

-- Navigate Windows
vim.keymap.set('n', '<C-h>', function()
  vscode.action 'workbench.action.navigateLeft'
end, { silent = true })
vim.keymap.set('n', '<C-l>', function()
  vscode.action 'workbench.action.navigateRight'
end, { silent = true })
vim.keymap.set('n', '<C-k>', function()
  vscode.action 'workbench.action.navigateUp'
end, { silent = true })
vim.keymap.set('n', '<C-j>', function()
  vscode.action 'workbench.action.navigateDown'
end, { silent = true })

-- Close Current window
vim.keymap.set('n', '<leader>c', function()
  vscode.action 'workbench.action.closeActiveEditor'
end, { silent = true })

vim.keymap.set('n', '<leader>u', function()
  vim.print 'Trying something out '
  vscode.call('reveal', { args = { 'center', 0 } })
end, { silent = true })

-- Toggle Sidebar
vim.keymap.set('n', '<leader>o', function()
  vscode.action 'workbench.action.toggleSidebarVisibility'
end, { silent = true })

-- Toggle Annoying Panel
vim.keymap.set('n', '<leader>p', function()
  vscode.action 'workbench.action.togglePanel'
end, { silent = true })

-- Quick Open ( File Search )
vim.keymap.set('n', '<leader>f', function()
  vscode.action 'workbench.action.quickOpen'
end, { silent = true })

-- Show Recent Projects
vim.keymap.set('n', '<leader>r', function()
  vscode.action 'workbench.action.openRecent'
end, { silent = true })

-- Show Open Editors
vim.keymap.set('n', '<leader><leader>', function()
  vscode.action 'workbench.action.showAllEditors'
end, { silent = true })

-- local vscode_extension_notify = function(name, args)
--   vim.rpcnotify(vim.g.vscode_channel, 'vscode-neovim', name, args)
-- end
--
-- local scroll_and_center = function(direction)
--   vim.schedule(function()
--     vscode_extension_notify('scroll', { 'halfPage', direction, })
--     vim.print 'scroll'
--   end)
--   vim.schedule(function()
--     vscode_extension_notify('move-cursor', { 'middle' })
--     vim.print 'move-cursor'
--   end)
-- end
--
-- vim.keymap.set('n', '<C-u>', function()
--   scroll_and_center('up')
-- end, { silent = true })
--
-- vim.keymap.set('n', '<C-d>', function()
--   scroll_and_center('down')
-- end, { silent = true })




-- Center
-- nnoremap zz <Cmd>call <SID>reveal('center', 0)<CR>
-- Half page
-- nnoremap <silent> <expr> <C-d> VSCodeExtensionNotify('scroll', 'halfPage', 'down')

--------------------------------------------------------------------------------
-- PLUGIN MAPPINGS--------------------------------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>w', function()
  require('hop').hint_words()
end, { silent = true, desc = 'Hop to any word' })
