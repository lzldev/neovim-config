vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- custom options
vim.g.transparent = true -- removes background on colorschemeload

-- NVIM options
vim.o.termguicolors = true
vim.o.cmdheight = 0
vim.o.hlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 16
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'

vim.o.tabstop = 2

if vim.g.vscode then
  require 'personal.vscode'
  return
end

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not package.loaded['lazy'] then
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
    { import = 'ui' },
    { 'rcarriga/nvim-notify', opts = {
      timeout = 1000,
    } },
    {
      'folke/noice.nvim',
      lazy = false,
      event = 'VeryLazy',
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
        'hrsh7th/nvim-cmp',
      },
      opts = {
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        documentation = {
          view = 'hover',
          ---@type NoiceViewOptions
          opts = {
            lang = 'markdown',
            replace = true,
            render = 'plain',
            format = { '{message}' },
            win_options = { concealcursor = 'n', conceallevel = 3 },
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      },
    },
    { 'wakatime/vim-wakatime' },
    { 'Shatur/neovim-session-manager', opts = {} },
    { 'nvimdev/hlsearch.nvim', opts = {} },
    { 'numToStr/Comment.nvim', opts = {} },
    -- <uwu>Surround</uwu>
    { 'tpope/vim-surround' },
    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },
    {
      'windwp/nvim-autopairs',
      -- Optional dependency
      dependencies = { 'hrsh7th/nvim-cmp' },
      opts = {},
      config = function(_, opts)
        require('nvim-autopairs').setup(opts)
        -- If you want to automatically add `(` after selecting a function or method
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end,
    },
    {
      'ThePrimeagen/harpoon',
      opts = {},
    },
    {
      'smoka7/hop.nvim',
      opts = {
        multi_windows = false,
      },
    },
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
      },
    },
    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',

        -- Adds a number of user-friendly snippets
        -- 'rafamadriz/friendly-snippets',
      },
    },
    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },
    {
      'Shatur/neovim-ayu',
      priority = 1000,
    },
    {
      'gambhirsharma/vesper.nvim',
      priority = 1000,
    },
    { 'ellisonleao/gruvbox.nvim' },
    {
      'nyoom-engineering/oxocarbon.nvim',
      priority = 1000,
    },
    {
      'rose-pine/neovim',
      priority = 1000,
    },
    {
      'navarasu/onedark.nvim',
      priority = 1000,
    },
    {
      'nvim-neo-tree/neo-tree.nvim',
      version = '*',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
      },
      opts = {
        filesystem = {
          hijack_netrw_behavior = 'open_current',
          filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        },
      },
    },
    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
    },
    -- Fuzzy Finder (files, lsp, etc)
    {
      'nvim-telescope/telescope.nvim',
      lazy = true,
      branch = '0.1.x',
      opts = {
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        defaults = {
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = { prompt_position = 'top', anchor = 'top' },
          },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      },
      config = function(_, opts)
        require('telescope').setup(opts)
        -- Enable telescope fzf native, if installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'notify')
        pcall(require('telescope').load_extension, 'ui-select')
      end,
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          lazy = true,
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
      },
    },
    { 'nvim-telescope/telescope-ui-select.nvim', lazy = true, opts = {} },
    { 'michaeljsmith/vim-indent-object' },
    {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
      },
      build = ':TSUpdate',
    },
    {
      'mhartington/formatter.nvim',
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
          -- 'tohtml',
          'zipPlugin',
        },
      },
    },
    dev = {
      path = '~/code/nvim-plugins',
    },
    -- profiling = {
    --   loader = true,
    --   require = true,
    -- },
  })
end

-- Theme
require 'personal.highlights'
vim.cmd.colorscheme 'rose-pine'

-- Autocommands
local autocmds = require 'personal.autocommands'

autocmds.highlight_on_yank()
autocmds.start_terminal_in_insert_mode()

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Move Lines
vim.keymap.set({ 'n' }, '<A-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set({ 'v' }, '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ 'i' }, '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

vim.keymap.set({ 'n' }, '<A-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set({ 'v' }, '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set({ 'i' }, '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true })

--ALTERNATE FILE
vim.keymap.set('n', '<C-0>', '<C-6>', { silent = true, desc = ' go to alternate file ' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- center after scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Write and quit all
vim.keymap.set('n', '<C-q>', vim.cmd.wqa, { silent = true })
vim.keymap.set('n', '<C-s>', vim.cmd.w, { silent = true })

-- Navigate windows quickly
vim.keymap.set('n', '<C-h>', function()
  vim.cmd.wincmd 'h'
end, { silent = true })
vim.keymap.set('n', '<C-l>', function()
  vim.cmd.wincmd 'l'
end, { silent = true })
vim.keymap.set('n', '<C-k>', function()
  vim.cmd.wincmd 'k'
end, { silent = true })
vim.keymap.set('n', '<C-j>', function()
  vim.cmd.wincmd 'j'
end, { silent = true })

-- Ctrl + Space as a Mapping to get out of term Mode
vim.keymap.set('t', '<C-Space>', '<C-\\><C-n><C-w>h', { silent = true, desc = 'get out of term mode' })

-- Lazygit
vim.keymap.set('n', '<leader>gg', function()
  vim.cmd.term 'lazygit'
end, { silent = true, desc = 'Open lazygit' })

-- Term splits
vim.keymap.set('n', '<leader>tv', function()
  vim.cmd ':vsplit +:term'
end, { silent = true, desc = 'terminal in [V]ertical split' })
vim.keymap.set('n', '<leader>ts', function()
  vim.cmd 'split +:term'
end, { silent = true, desc = 'terminal in horizontal [S]plit' })

-- Buffers
vim.keymap.set('n', '<A-Tab>', vim.cmd.bn, { silent = true, desc = 'Next Buffer' })
vim.keymap.set('n', '<A-S-Tab>', vim.cmd.bp, { silent = true, desc = 'Previous Buffer' })

vim.keymap.set('n', '<leader>c', vim.cmd.bw, { silent = true, desc = 'Wipeout Buffer' })
-- Wipeout buffers to the right
vim.keymap.set('n', '<leader>br', function()
  vim.cmd '.+,$bw'
end, { silent = true, desc = 'Wipes all buffers to the right' })

-- Wipeout Buffers to the left
vim.keymap.set('n', '<leader>bl', function()
  if not require('utils').is_first_buf() then
    vim.cmd '1,.-bw'
  end
end, { silent = true, desc = 'Wipes all buffers to the left' })

-- Wipeout other buffers
vim.keymap.set('n', '<leader>bo', function()
  if not require('utils').is_first_buf() then
    vim.cmd '1,.-bw'
  end
  vim.cmd '.+,$bw'
end, { silent = true, desc = 'Wipes all other buffers' })

-- Write and source file  ( for plugin dev and etc .. )
vim.keymap.set('n', '<leader>px', function()
  vim.cmd.w()
  vim.cmd.source '%'
end, { silent = true, desc = 'Write file and source' })

--------------------------------------------------------------------------------
---------------------------------- UI MAPPINGS ---------------------------------
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>ub', function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  elseif vim.o.background == 'light' then
    vim.o.background = 'dark'
  end
  vim.print(vim.o.background)
end, { silent = true, desc = 'Toggle Background' })

-- Toggle Transparency
vim.keymap.set('n', '<leader>ut', function()
  vim.g.transparent = not vim.g.transparent
  vim.print('transparent : ' .. vim.inspect(vim.g.transparent))
  vim.cmd.colorscheme(vim.g.colors_name)
end, { silent = true, desc = 'Toggle transparency' })

-- Toggle Wrap
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.print('Wrap : ' .. vim.inspect(vim.wo.wrap))
end, { silent = true, desc = 'Toggle wrap' })

-- Dismiss Notifications Dismiss
vim.keymap.set('n', '<leader>ud', require('notify').dismiss, { silent = true, desc = '[N] Dismiss notifications' })

--------------------------------------------------------------------------------
-------------------------------- Plugin Mappings -------------------------------
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>uz', vim.cmd.NoNeckPain, { silent = true, desc = 'Center Window' })

vim.keymap.set('n', '<leader>pp', vim.cmd.Lazy, { silent = true, desc = 'Open Lazy' })
vim.keymap.set('n', '<leader>pm', vim.cmd.Mason, { silent = true, desc = 'Open Mason' })

-- Neo-tree Reveal
vim.keymap.set('n', '<leader>o', function()
  require('neo-tree.command').execute {
    action = 'show',
    reveal = true,
    position = 'current',
  }
end, { silent = true, desc = 'Toggles Neotree' })

-- NVIM HOP
vim.keymap.set('n', '<leader>w', function()
  require('hop').hint_words {}
end, { silent = true, desc = 'Hop: Hint Words' })

-- SESSIONS
vim.keymap.set('n', '<leader>ss', require('session_manager').load_session, { silent = true, desc = 'load session' })

vim.keymap.set('n', '<A-w>', require('harpoon.ui').toggle_quick_menu, { silent = true, desc = 'harpoon : open menu' })
vim.keymap.set('n', '<A-q>', require('harpoon.mark').toggle_file, { silent = true, desc = 'harpoon : mark file' })

vim.keymap.set('n', '<A-1>', function()
  require('harpoon.ui').nav_file(1)
end, { silent = true })
vim.keymap.set('n', '<A-2>', function()
  require('harpoon.ui').nav_file(2)
end, { silent = true })
vim.keymap.set('n', '<A-3>', function()
  require('harpoon.ui').nav_file(3)
end, { silent = true })
vim.keymap.set('n', '<A-4>', function()
  require('harpoon.ui').nav_file(4)
end, { silent = true })
vim.keymap.set('n', '<A-5>', function()
  require('harpoon.ui').nav_file(5)
end, { silent = true })
vim.keymap.set('n', '<A-6>', function()
  require('harpoon.ui').nav_file(6)
end, { silent = true })

--------------------------------------------------------------------------------
-------------------------------- Telescope -------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>"', require('telescope.builtin').registers, { desc = 'Find in Registers' })
vim.keymap.set('n', "<leader>'", require('telescope.builtin').marks, { desc = 'Find in Marks' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>sF', function()
  require('telescope.builtin').find_files {
    no_ignore = false,
  }
end, { desc = '[S]earch All [F]ile' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>st', function()
  require('telescope.builtin').colorscheme { enable_preview = true }
end, { desc = '[S]earch [T]hemes' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles, { desc = '[S]earch [O]ld Files' })
vim.keymap.set('n', '<leader>sm', function()
  require('telescope.builtin').man_pages {
    sections = { 'ALL' },
  }
end, { desc = '[S]earch [O]ld Files' })

--------------------------------------------------------------------------------
---------------------------- Telescope Extension -------------------------------
--------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>sn', require('telescope').extensions.notify.notify, { desc = '[S]earch [N]otifications' })

--------------------------------------------------------------------------------
---------------------------- Treesitter Config ---------------------------------
--------------------------------------------------------------------------------
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
      'regex',
      'markdown',
      'markdown_inline',
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

--------------------------------------------------------------------------------
---------------------------------- LSP -----------------------------------------
--------------------------------------------------------------------------------

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--
--

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  if not not vim.lsp.inlay_hint then
    nmap('<A-l>', function()
      vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end, [[Toggle inlay hints]])
  end

  nmap('<leader>lr', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')
  nmap('<leader>lo', require('telescope.builtin').lsp_outgoing_calls, '[O]utgoing Calls')
  nmap('<leader>li', require('telescope.builtin').lsp_incoming_calls, '[I]ncoming Calls')
  nmap('<leader>lf', require('telescope.builtin').lsp_document_symbols, '[F]ile Symbols')
  -- nmap('<leader>lc', require('telescope.builtin').lsp_document_symbols, '[F]ile Symbols')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [D]eclaration')

  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>Ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- Show Signature on L
  nmap('L', vim.lsp.buf.signature_help, 'Signature Documentation')

  --Format
  nmap('<leader>j', vim.cmd.Format, 'Format')
  -- Lesser used LSP functionality
  nmap('<leader>Wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>Wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>Wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  -- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>W'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>u'] = { name = '[U]i', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = '[B]uffers', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]eminal', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
  ['<leader>n'] = { name = '[N]otifications', _ = 'which_key_ignore' },
  ['<C-G>'] = { name = 'print filename', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()
require('formatter').setup {
  logging = true,
  cwd = function()
    vim.print 'FORMATTER CWD'
    local workspace_root = vim.lsp.buf.list_workspace_folders()[1]

    return workspace_root
  end,
  filetype = {
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
    c = {
      require('formatter.filetypes.c').clangformat,
    },
    rust = {
      require('formatter.filetypes.rust').rustfmt,
    },
    html = {
      require('formatter.filetypes.javascript').prettierd,
    },
    kotlin = {
      require('formatter.filetypes.kotlin').ktlint(),
    },
    java = {
      require('formatter.filetypes.java').clangformat(),
    },
    javascript = {
      require('formatter.filetypes.javascript').prettierd,
    },
    javascriptreact = {
      require('personal.formatters').rustywind,
      require('formatter.filetypes.javascriptreact').prettierd,
    },
    typescript = {
      require('formatter.filetypes.typescript').prettierd,
    },
    typescriptreact = {
      require('personal.formatters').rustywind,
      require('formatter.filetypes.typescriptreact').prettierd,
    },
    go = { require('formatter.filetypes.go').gofmt() },
    json = {
      require('formatter.filetypes.json').prettierd,
    },
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
  },
}

-- Enable the following language servers
local servers = {
  clangd = {},
  gopls = {
    build = {
      templateExtensions = {"tmpl",".tmpl"}
    }
  },
  -- pyright = {},
  templ = {},
  rust_analyzer = {
    ['rust-analyzer'] = {
      check = {
        allTargets = true,
      },
      diagnostics = {
        enable = false,
      },
    },
  },
  -- Java/Kotlin
  kotlin_language_server = {},
  ast_grep = {},
  jdtls = {
    ""
  },
  --
  tailwindcss = {
    filetypes = {
      'aspnetcorerazor',
      'astro',
      'astro - markdown',
      'blade',
      'clojure',
      'django - html',
      'htmldjango',
      'edge',
      'eelixir',
      'elixir',
      'ejs',
      'erb',
      'eruby',
      'gohtml',
      'gohtmltmpl',
      'haml',
      'handlebars',
      'hbs',
      'html',
      'html - eex',
      'heex',
      'jade',
      'leaf',
      'liquid',
      'markdown',
      'mdx',
      'mustache',
      'njk',
      'nunjucks',
      'php',
      'razor',
      -- "slim",
      -- "twig",
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      -- "javascript",
      'javascriptreact',
      'reason',
      'rescript',
      -- "typescript",
      'typescriptreact',
      'vue',
      'svelte',
    },
  },
  eslint = {},
  elixirls = {},
  tsserver = {
    implicitProjectConfig = { checkJs = true },
    preferences = { useAliasesForRenames = false },
    ['js/ts'] = {
      implicitProjectConfig = { checkJs = true },
    },
    javascript = {
      preferences = { useAliasesForRenames = false },
      implicitProjectConfig = { checkJs = true },
      enablePromptUseWorkspaceTsdk = true,
    },
    typescript = {
      implicitProjectConfig = { checkJs = true },
      preferences = { useAliasesForRenames = false },
      enablePromptUseWorkspaceTsdk = true,
      preferGoToSourceDefinition = true,
      tsdk = 'node_modules/typescript/lib',
    },
  },
  ['astro'] = { filetypes = { 'astro' } },
  -- html = { filetypes = { 'html', 'javascriptreact', 'typescriptreact' } },
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
-- i think this is breaking my nvim cmp so do this.
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}

---@diagnostic disable-next-line: missing-fields
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'sources' },
    -- { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   -- if cmp.visible() then
    --   --   cmp.select_next_item()
    --   -- elseif luasnip.expand_or_locally_jumpable() then
    --     -- luasnip.expand_or_jump()
    --   -- else
    --     fallback()
    --   -- end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   -- if cmp.visible() then
    --     -- cmp.select_prev_item()
    --   -- elseif luasnip.locally_jumpable(-1) then
    --     -- luasnip.jump(-1)
    --   -- else
    --     fallback()
    --   -- end
    -- end, { 'i', 's' }),
  },
}

require 'personal.globals'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
