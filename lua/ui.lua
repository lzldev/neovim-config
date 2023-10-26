return {
  {
    'shortcuts/no-neck-pain.nvim',
    opts = {
      width = 110,
      buffers = {
        colors = {
          blend = 10
        },
        wo = {
          fillchars = 'eob: ',
        },
      },
    },
  },
  { 'SmiteshP/nvim-navic', opts = {lsp ={auto_attach = true}}, after = 'nvim-lualine/lualine.nvim' },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    lazy = false,
    priority = 900,
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'auto',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename','searchcount'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 4,
            buffers_color = {
              active = 'Underlined',
            },
            use_mode_colors = true,
          },
        },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        lualine_y = { 'datetime' },
        lualine_z = { 'tabs' },
      },
      winbar = {
        lualine_a = {{ 'navic' , color_correction = 'dynamic'}},
        lualine_c = {},
        lualine_x = {{function() return 'miau ~.~' end}},
        lualine_y = { 'branch' },
        lualine_z = { 'diff' },
      },
    },
  },
}
