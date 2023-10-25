return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    lazy = false,
    priority = 900,
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 4,
            buffers_color = {
              active = 'Underlined'
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
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'branch' },
        lualine_z = { 'diff' },
      },
    },
  },
}
