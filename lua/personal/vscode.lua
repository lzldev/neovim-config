vim.print '[STARTING IN VSCODE MODE]'
vim.cmd.colorscheme 'darkblue'

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
    { 'michaeljsmith/vim-indent-object' },
    { 'michaeljsmith/vim-indent-object' },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
      build = ':TSUpdate',
    },
    { 'tpope/vim-surround' },
    {
      'smoka7/hop.nvim',
      opts = {
        multi_windows = false,
      },
    },
  },
}, {
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disables regular vim plugins
      disabled_plugins = {
        'gzip',
        -- 'matchit',
        -- 'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Configure Treesitter
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    modules = {},
    sync_install = false,
    ignore_install = {},
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- Register autocommands
require('personal.autocommands').highlight_on_yank()

--------------------------------------------------------------------------------
-- Mappings --------------------------------------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-0>', '<C-6>', { silent = true, desc = ' go to alternate file ' })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center after scroll
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Write and quit all
vim.keymap.set('n', '<C-q>', vim.cmd.wqa, { silent = true })
vim.keymap.set('n', '<C-s>', vim.cmd.w, { silent = true })

--------------------------------------------------------------------------------
-- VSCODE Commands -------------------------------------------------------------
--------------------------------------------------------------------------------

local vscode = require 'vscode-neovim'

-- Context Menu 
vim.keymap.set('n', 'M', function()
  vscode.action 'editor.action.showContextMenu'
end, { silent = true })


-- Function Signature
vim.keymap.set('n', 'L', function()
  vscode.action 'editor.action.triggerParameterHints'
end, { silent = true })

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

--Toggle Line Wrap
vim.keymap.set('n', '<leader>uw', function()
  vscode.action 'editor.action.toggleWordWrap'
end, { silent = true })

-- Show Command thingy
vim.keymap.set('n', '<leader>k', function()
  vscode.action 'workbench.action.showCommands'
end, { silent = true })

--------------------------------------------------------------------------------
-- Manage Editors --------------------------------------------------------------
--------------------------------------------------------------------------------

-- Close Current Editor
vim.keymap.set('n', '<leader>c', function()
  vscode.action 'workbench.action.closeActiveEditor'
end, { silent = true })

--Close all Editors
vim.keymap.set('n', '<leader>ba', function()
  vscode.action 'workbench.action.closeAllEditors'
end, { silent = true })

-- Close Editors to the left
vim.keymap.set('n', '<leader>bl', function()
  vscode.action 'workbench.action.closeEditorsToTheLeft'
end, { silent = true })

-- Close Editors to the right
vim.keymap.set('n', '<leader>br', function()
  vscode.action 'workbench.action.closeEditorsToTheRight'
end, { silent = true })

-- Close Other Editors
vim.keymap.set('n', '<leader>bo', function()
  vscode.action 'workbench.action.closeOtherEditors'
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
  require('hop').hint_words {
    dim_unmatched = false,
  }
end, { silent = true, desc = 'Hop to any word' })
