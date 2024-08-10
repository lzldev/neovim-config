local hi_transparent = {
  Normal = { 'guibg=NONE' },
  NormalNC = { 'guibg=NONE' },
}

local hi_overrides = {
  defaults = {
    NotifyBackground = { 'guibg=#000000' },
  },
  ayu = {
    LineNrAbove = { 'guifg=#39bae6' },
    LineNrBelow = { 'guifg=#39bae6' },
    LineNr = {'guifg=#ffb454'}
  },
  oxocarbon = {
    Comment = { 'guifg=#de95ff' },
    -- Comment = { 'guifg=#fcb5c6' },
  },
}

--
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    for highlight, value in pairs(hi_overrides['defaults']) do
      vim.cmd.highlight(highlight, table.unpack(value))
    end

    local c = vim.g.colors_name

    if hi_overrides[c] ~= nil then
      for highlight, value in pairs(hi_overrides[c]) do
        vim.cmd.highlight(highlight, table.unpack(value))
      end
    end

    -- Remove Background
    if vim.g.transparent then
      for highlight, value in pairs(hi_transparent) do
        vim.cmd.highlight(highlight, table.unpack(value))
      end
    end
  end,
})
